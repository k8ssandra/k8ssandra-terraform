# Copyright 2021 Datastax LLC
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

# Create Compute Network for GKE
resource "google_compute_network" "compute_network" {
  name    = format("%s-network", var.name)
  project = var.project_id
  # Always define custom subnetworks- one subnetwork per region isn't useful for an opinional setup
  auto_create_subnetworks = "false"

  # A global routing mode can have an unexpected impact on load balancers; always use a regional mode
  routing_mode = "REGIONAL"
}


# This Cloud Router is used only for the Cloud NAT.
resource "google_compute_router" "vpc_compute_router" {
  # Only create the Cloud NAT if it is enabled.
  depends_on = [
    google_compute_network.compute_network
  ]
  count   = var.enable_cloud_nat ? 1 : 0
  name    = format("%s-router", var.name)
  project = var.project_id
  region  = var.region
  network = google_compute_network.compute_network.self_link
}


# create compute router NAT service
resource "google_compute_router_nat" "compute_router_nat" {
  # Only create the Cloud NAT if it is enabled.
  count   = var.enable_cloud_nat ? 1 : 0
  name    = format("%s-nat", var.name)
  project = var.project_id
  // Because router has the count attribute set we have to use [0] here to
  // refer to its attributes.
  router  = google_compute_router.vpc_compute_router[0].name
  region  = google_compute_router.vpc_compute_router[0].region

  nat_ip_allocate_option = "AUTO_ONLY"
  
  # Apply NAT to all IP ranges in the subnetwork.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
 
  log_config {
    enable = var.enable_cloud_nat_logging
    filter = var.cloud_nat_logging_filter
  }
}


// Create a public subnets config
resource "google_compute_subnetwork" "compute_subnetwork" {
  name    = format("%s-subnet", var.name)
  project = var.project_id
  network = google_compute_network.compute_network.self_link
  region  = var.region

  private_ip_google_access = true
  ip_cidr_range            = cidrsubnet(var.cidr_block, var.cidr_subnetwork_width_delta, 0)

  secondary_ip_range {
    range_name = format("%s-subnet",var.name)
    ip_cidr_range = cidrsubnet(
      var.secondary_cidr_block,
      var.secondary_cidr_subnetwork_width_delta,
      0
    )
  }
}

# Firewall rules
# Allow http traffic
resource "google_compute_firewall" "http_compute_firewall" {
  name = format("%s-fw-allow-http", var.name)
  network = google_compute_network.compute_network.name
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"]
}

# Allow https traffic
resource "google_compute_firewall" "https_compute_firewall" {
  name = format("%s-fw-allow-https", var.name)
  network = google_compute_network.compute_network.name
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["https"]
}

# Allow ssh traffic
resource "google_compute_firewall" "ssh_compute_firewall" {
  name = format("%s-fw-allow-ssh", var.name)
  network = google_compute_network.compute_network.name
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}

# Allow rdp traffic
resource "google_compute_firewall" "rdp_compute_firewall" {
  name = format("%s-fw-allow-rdp", var.name)
  network = google_compute_network.compute_network.name
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  target_tags = ["rdp"]
}
