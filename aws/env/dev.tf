module "vpc" {
  source      = "../modules/vpc"
  name        = local.name_prefix
  environment = var.environment
}

module "eks" {
  source      = "../modules/eks"
  name        = local.name_prefix
  environment = var.environment
}

module "iam" {
  source      = "../modules/iam"
  name        = local.name_prefix
  environment = var.environment
}
