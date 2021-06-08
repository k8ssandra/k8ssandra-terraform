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

variable "environment" {
  description = "Name of the environment where infrastructure being built."
  type        = string
}

variable "name" {
  description = "Name is the prefix to use for resources that needs to be created."
  type        = string
}

variable "region" {
  description = "Azure location where all the resources being created."
  type        = string
}

variable "resource_owner" {
  description = "The name of the Account Owner"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of the Azure kubernetes cluster"
  default     = "1.19.9"
  type        = string
}

variable "node_count" {
  description = "Number of AKS worker nodes"
  type        = number
  default     = 3
}

variable "min_count" {
  description = "Minimum Node Count"
  default     = 3
  type        = number
}

variable "max_count" {
  description = "Maximum Node Count"
  default     = 5
  type        = number
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_E8_v4"
  type        = string
}

variable "public_subnet_prefixes" {
  description = "value"
  type        = list(string)
  default     = ["10.1.0.0/24"]
}

variable "private_subnet_prefixes" {
  description = "value"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "private_service_endpoints" {
  description = "service endpoints to attach Private Subnets."
  type        = list(string)
  default     = ["Microsoft.Storage"]
}

variable "public_service_endpoints" {
  description = "service endpoints to attche public Subnets."
  type        = list(string)
  default     = []
}

locals {
  # Prefix of the resourecs.
  prefix = format("%s-%s", lower(var.environment), lower(var.name))

  tags = {
    "environment"     = var.environment
    "resource-owner"  = var.resource_owner
    "location"        = var.region
    "subscription_id" = data.azurerm_subscription.current.display_name
  }
}

# Current subscription id.
data "azurerm_subscription" "current" {
}
