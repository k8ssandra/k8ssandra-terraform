module "aks" {
  source              = "../modules/aks"
  name                = var.cluster_name
  environment         = var.environment
  resource_group_name = var.resource_group_name
  node_count          = var.node_count
  node_resource_group = var.node_resource_group
}

module "vpc" {
  source              = "../modules/vpc"
  environment         = var.environment
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}
