# Copyright 2021 Datastax LLC
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
  type        = string
}

variable "project_id" {
  description = "The project in which to hold the components"
  type        = string
}

variable "service_account_custom_iam_roles" {
  description = "service account custom iam roles"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
}

variable "service_account_iam_roles" {
  description = "service account custom iam roles"
  type        = list(string)
}

variable "project_services" {
  type    = list(string)
  default = []
}
