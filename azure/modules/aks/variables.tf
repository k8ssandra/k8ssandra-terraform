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

# Kubernetes cluster configuration variables
variable "kubernetes_version" {
  description = "Version of the AKS cluster."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "user_assigned_id" {
  description = "The name of the user identity in which the resources will be created."
  type        = string
}

# Variables for the default node_pool.
variable "private_subnet" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
  type        = string
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  type        = string
}

variable "node_count" {
  description = "Number of nodes to deploy"
  type        = number
}

variable "min_count" {
  description = "Minimum Node Count"
  type        = number
}
variable "max_count" {
  description = "Maximum Node Count"
  type        = number
}

# variables for AKS network profile. network_plugin, docker_bridge_cidr, dns_service_ip, service_cidr.
# Set all the values or unset all the values, cidr ranges must not overlap with subnet's.
# service_cidr for the AKS cluster, defaults to 10.0.0.0/16.
variable "network_plugin" {
  description = "Network plugin type"
  default     = "azure"
  type        = string
}
variable "docker_bridge_cidr" {
  description = "CNI Docker bridge CIDR"
  default     = "172.17.0.1/16"
  type        = string
}

variable "dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "10.2.0.10"
  type        = string
}

variable "service_cidr" {
  description = "CNI service CIDR"
  default     = "10.2.0.0/24"
  type        = string
}

# tags
variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(string)
  default     = {}
}
