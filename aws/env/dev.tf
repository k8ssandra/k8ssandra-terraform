module "vpc" {
  source             = "../modules/vpc"
  name               = local.name_prefix
  environment        = var.environment
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  tags               = local.tags
}

module "eks" {
  source                = "../modules/eks"
  name                  = local.name_prefix
  environment           = var.environment
  role_arn              = module.iam.role_arn
  subnet_ids            = module.vpc.aws_subnet_private_ids
  security_group_id     = module.vpc.security_group_id
  public_subnets        = module.vpc.aws_subnet_public_ids
  instance_profile_name = module.iam.iam_instance_profile
  tags                  = local.tags
}

module "iam" {
  source      = "../modules/iam"
  name        = local.name_prefix
  environment = var.environment
  tags        = local.tags
}
