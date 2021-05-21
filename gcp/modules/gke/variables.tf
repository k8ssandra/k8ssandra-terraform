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

variable "name" {
  description = "Name of the cluster"
  type        = string
}

variable "environment" {
  description = "Name of the environment the infrasstructure is being built."
  type        = string
}

variable "project_id" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  description = "Type of machines which are used by cluster node pool"
  type        = string
  default     = "e2-highmem-8"
}

variable "region" {
  description = "The location of the GKE cluster."
  type        = string
}

variable "network_link" {
  description = "network link variable from vpc module outputs"
  default     = ""
}

variable "subnetwork_link" {
  description = "subnetworking link variable from vpc module outputs"
  default     = ""
}

variable "service_account" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters"
  default     = ""
}

variable "enable_private_endpoint" {
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
  default     = false
  type        = bool
}

variable "enable_private_nodes" {
  description = "(Beta) Whether nodes have internal IP addresses only"
  default     = false
  type        = bool
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation (size must be /28) to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."
  default     = "10.0.0.0/28"
}
