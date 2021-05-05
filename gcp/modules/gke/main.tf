# Copyright 2021 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Google container cluster(GKE) configuration
resource "google_container_cluster" "container_cluster" {
  name                     = var.name
  project                  = var.project_id
  description              = format("%s-gke-cluster", var.name)
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  # VPC and Subnet work self links. 
  network    = var.network_link
  subnetwork = var.subnetwork_link

  master_auth {
    # Setting an empty username and password explicitly disables basic auth
    username = ""
    password = ""

    # Whether client certificate authorization is enabled for this cluster.
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Private Cluster configuration
  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
  }

  # Resource lables
  resource_labels = {
    environment = format("%s", var.environment)
  }

  # Creates Internal Load Balancer
  addons_config {
    http_load_balancing {
      disabled = false
    }
  }

  # Provisioner to connect the GEK cluster. 
  provisioner "local-exec" {
    command = format("gcloud container clusters get-credentials %s --region %s --project %s", google_container_cluster.container_cluster.name, google_container_cluster.container_cluster.location, var.project_id)
  }

}

# Google container node pool configuration
resource "google_container_node_pool" "container_node_pool" {
  name       = format("%s-node-pool", var.name)
  project    = var.project_id
  location   = var.region
  cluster    = google_container_cluster.container_cluster.name
  node_count = 1

  # Node configuration
  node_config {
    machine_type = var.machine_type
    preemptible  = true
    tags         = ["http", "ssh", "rdp"]

    metadata = {
      disable-legacy-endpoints = "true"
    }


    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  depends_on = [
    google_container_cluster.container_cluster
  ]
}

# TODO : Go program to replace this. 
# Test the connectivity to GKE cluster that just got created.
