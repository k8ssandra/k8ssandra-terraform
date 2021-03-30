resource "google_container_cluster" "container_cluster" {
  name        = var.name
  project     = var.project
  description = "Demo GKE Cluster"
  location    = var.location

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  #network    = google_compute_network.compute_network.self_link
  #subnetwork = google_compute_subnetwork.compute_subnetwork.self_link

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

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
