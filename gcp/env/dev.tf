module "datastax_vpc" {
  source = "../modules/vpc"
  name  = var.name
  region = var.region
  project_id = var.project_id
  project_services = var.project_services
}

# first cluster 
module "first_gke_cluster" {
  source = "../modules/gke"
  name   = var.name
  region  = var.region
  #network_link =  module.datastax_vpc.google_compute_network.compute_network.self_link
  #subnetwork_link = module.datastax_vpc.google_compute_subnetwork.compute_subnetwork.self_link
}


module "datastax_iam" {
  source = "../modules/iam"
  name   = var.name
  region  = var.region
  project_id = var.project_id
  service_account_custom_iam_roles = var.service_account_custom_iam_roles
  service_account_iam_roles = var.service_account_iam_roles
}
