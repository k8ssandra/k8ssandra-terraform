// Create a network for GKE
resource "google_compute_network" "compute_network" {
  name    = format("%s-network", var.name)
  project = var.project_id
  # Always define custom subnetworks- one subnetwork per region isn't useful for an opinionated setup
  auto_create_subnetworks = "false"

  # A global routing mode can have an unexpected impact on load balancers; always use a regional mode
  routing_mode = "REGIONAL"
}

# This Cloud Router is used only for the Cloud NAT.
resource "google_compute_router" "vpc_compute_router" {
  # Only create the Cloud NAT if it is enabled.
  count   = var.enable_cloud_nat ? 1 : 0
  name    = format("%s-router", var.name)
  project = var.project_id
  region  = var.region
  network = google_compute_network.compute_network.self_link
}


# https://www.terraform.io/docs/providers/google/r/compute_router_nat.html
resource "google_compute_router_nat" "compute_router_nat" {
  # Only create the Cloud NAT if it is enabled.
  count = var.enable_cloud_nat ? 1 : 0
  name  = format("%s-nat", var.name)
  // Because router has the count attribute set we have to use [0] here to
  // refer to its attributes.
  router = google_compute_router.vpc_compute_router[0].name
  region = google_compute_router.vpc_compute_router[0].region
  # For this example project just use IPs allocated automatically by GCP.
  nat_ip_allocate_option = "AUTO_ONLY"
  # Apply NAT to all IP ranges in the subnetwork.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = var.enable_cloud_nat_logging
    filter = var.cloud_nat_logging_filter
  }
}


// Create subnets config
resource "google_compute_subnetwork" "compute_subnetwork" {
  name    = format("%s-subnet", var.name)
  project = var.project_id
  network = google_compute_network.compute_network.self_link
  region  = var.region
  #ip_cidr_range = "10.0.0.0/24"

  private_ip_google_access = true
  ip_cidr_range            = cidrsubnet(var.cidr_block, var.cidr_subnetwork_width_delta, 0)

  secondary_ip_range {
    range_name = "public-services"
    ip_cidr_range = cidrsubnet(
      var.secondary_cidr_block,
      var.secondary_cidr_subnetwork_width_delta,
      0
    )
  }
}

// Create private subnets
resource "google_compute_subnetwork" "private_compute_subnetwork" {
  name    = format("%s-private-subnet", var.name)
  project = var.project_id
  network = google_compute_network.compute_network.self_link
  region  = var.region
  #ip_cidr_range = "10.0.0.0/24"

  private_ip_google_access = true
  ip_cidr_range = cidrsubnet(
    var.cidr_block,
    var.cidr_subnetwork_width_delta,
    1 * (1 + var.cidr_subnetwork_spacing)
  )

  secondary_ip_range {
    range_name = "private-services"
    ip_cidr_range = cidrsubnet(
      var.secondary_cidr_block,
      var.secondary_cidr_subnetwork_width_delta,
      1 * (1 + var.secondary_cidr_subnetwork_spacing)
    )
  }
}
