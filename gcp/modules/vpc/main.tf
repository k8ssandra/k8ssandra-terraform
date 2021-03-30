// Create a network for GKE
resource "google_compute_network" "compute_network" {
  name                    = format("%s-network", var.name)
  project                 = var.project_id
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.project_service
  ]
}


// Create subnets
resource "google_compute_subnetwork" "compute_subnetwork" {
  name          = format("%s-subnet", var.name)
  project       = var.project_id
  network       = google_compute_network.compute_network.self_link
  region        = var.region
  ip_cidr_range = "10.0.0.0/24"

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = format("%s-pod-range", var.name)
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = format("%s-svc-range", var.name)
    ip_cidr_range = "10.2.0.0/20"
  }
}


// Enable required services on the project
resource "google_project_service" "project_service" {
  count   = length(var.project_services)
  project = var.project_id
  service = element(var.project_services, count.index)

  // Do not disable the service on destroy. On destroy, we are going to
  // destroy the project, but we need the APIs available to destroy the
  // underlying resources.
  disable_on_destroy = false
}
