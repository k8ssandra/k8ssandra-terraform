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

# Terraform modules
# Azure Kubernetes service module.
module "aks" {
  source              = "../modules/aks"
  name                = local.prefix
  environment         = var.environment
  kubernetes_version  = var.kubernetes_version
  node_count          = var.node_count
  max_count           = var.max_count
  min_count           = var.min_count
  resource_group_name = module.iam.resource_group_name
  location            = module.iam.location
  private_subnet      = module.vnet.private_subnets
  user_assigned_id    = module.iam.user_id
  vm_size             = var.vm_size


  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}

# Azure Virtuval network module
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

# Azure Identities module
module "iam" {
  source      = "../modules/iam"
  name        = local.prefix
  environment = var.environment
  location    = var.region
  tags        = local.tags
}

# Azure Storage Account module
module "storage" {
  source              = "../modules/storage"
  name                = local.prefix
  environment         = var.environment
  resource_group_name = module.iam.resource_group_name
  location            = module.iam.location

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}
