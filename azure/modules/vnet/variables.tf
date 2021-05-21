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

# Common variables.
variable "location" {
  description = "Azure location where all the resources being created."
  type        = string
}

variable "name" {
  description = "Name is the prefix to use for resources that needs to be created."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastructure being built."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

# Vnet address space
variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.1.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "public_subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}

variable "private_subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}

variable "public_service_endpoints" {
  description = "A map of subnet name to service endpoints to add to the subnet."
  type        = list(string)
  default     = []
}

variable "private_service_endpoints" {
  description = "A map of subnet name to service endpoints to add to the subnet."
  type        = list(string)
  default     = []
}

variable "policy_id" {
  description = "subnet service storage endpoint policy id."
  type        = string
}

variable "endpoint_network_policies" {
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
  type        = bool
  default     = true
}

variable "service_network_policies" {
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
  type        = bool
  default     = true
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}
