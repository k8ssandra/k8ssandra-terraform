# Copyright 2021 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Create Virtual Private Cloud
module "vpc" {
  source             = "../modules/vpc"
  name               = local.name_prefix
  environment        = var.environment
  region             = var.region
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  tags               = local.tags
}

# Create Elastic Kubernetes Service
module "eks" {
  source                = "../modules/eks"
  name                  = local.name_prefix
  region                = var.region
  environment           = var.environment
  instance_type         = var.instance_type
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  role_arn              = module.iam.role_arn
  worker_role_arn       = module.iam.worker_role_arn
  subnet_ids            = module.vpc.aws_subnet_private_ids
  security_group_id     = module.vpc.security_group_id
  public_subnets        = module.vpc.aws_subnet_public_ids
  instance_profile_name = module.iam.iam_instance_profile
  tags                  = local.tags
}

# Create Identity Access Management
module "iam" {
  source      = "../modules/iam"
  name        = local.name_prefix
  region      = var.region
  environment = var.environment
  tags        = local.tags
  bucket_id   = module.s3.bucket_id
}

# Create S3 bucket
module "s3" {
  source      = "../modules/s3"
  name        = local.name_prefix
  environment = var.environment
  tags        = local.tags
}
