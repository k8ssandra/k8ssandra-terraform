resource "google_container_cluster" "container_cluster" {
  name        = var.name
  project     = var.project
  description = "Demo GKE Cluster"
  location    = var.location

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

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
}

resource "google_container_node_pool" "container_node_pool" {
  name       = format("%s-node-pool", var.name)
  project    = var.project
  location   = var.location
  cluster    = google_container_cluster.container_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
