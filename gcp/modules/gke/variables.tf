# copyright 2020 Datastax LLC
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
  description = "name of the cluster"
}

variable "project_id" {
  description = "project ID"
  default     = ""
}

variable "location" {
  description = "name of the region"
  default     = "us-central1"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  description = "name of the machine_type"
  default     = "n1-standard-8"
}

variable "region" {
  description = "name of the region"
}

variable "network_link" {
  description = "network link"
  default     = ""
}

variable "subnetwork_link" {
  description = "subnetworking link"
  default     = ""
}

variable "service_account" {
  default = ""
}
