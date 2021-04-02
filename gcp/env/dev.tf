module "datastax_vpc" {
  source     = "../modules/vpc"
  name       = var.name
  region     = var.region
  project_id = var.project_id
  //  project_services = var.project_services
}

# first cluster 
module "first_gke_cluster" {
  source          = "../modules/gke"
  name            = var.name
  region          = var.region
  project         = var.project_id
  network_link    = module.datastax_vpc.network_selflink
  subnetwork_link = module.datastax_vpc.subnetwork_selflink
  service_account = module.datastax_iam.service_account
}


module "datastax_iam" {
  source                           = "../modules/iam"
  name                             = var.name
  region                           = var.region
  project_id                       = var.project_id
  service_account_custom_iam_roles = var.service_account_custom_iam_roles
  service_account_iam_roles        = var.service_account_iam_roles
}
