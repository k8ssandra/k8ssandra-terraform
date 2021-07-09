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

#variables
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

variable "public_subnet" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
  type        = string
}

variable "appgw_id" {
  description = "The id of the Application gateway"
  type        = string
}

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(string)
}
