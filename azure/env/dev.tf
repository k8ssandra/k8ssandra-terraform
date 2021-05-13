module "aks" {
  source              = "../modules/aks"
  name                = local.prefix
  environment         = var.environment
  kubernetes_version  = var.kubernetes_version
  resource_group_name = module.iam.resource_group_name
  location            = module.iam.location
  private_subnet      = module.vnet.private_subnets
  user_assigned_id    = module.iam.user_id

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}

module "vnet" {
  source                    = "../modules/vnet"
  name                      = local.prefix
  environment               = var.environment
  resource_group_name       = module.iam.resource_group_name
  location                  = module.iam.location
  public_subnet_prefixes    = var.public_subnet_prefixes
  private_subnet_prefixes   = var.private_subnet_prefixes
  private_service_endpoints = var.private_service_endpoints
  policy_id                 = module.storage.policy_id

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}

module "iam" {
  source      = "../modules/iam"
  name        = local.prefix
  environment = var.environment
  location    = var.region
  tags        = local.tags
}

module "storage" {
  source              = "../modules/storage"
  name                = local.prefix
  environment         = var.environment
  resource_group_name = module.iam.resource_group_name
  location            = module.iam.location

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}
