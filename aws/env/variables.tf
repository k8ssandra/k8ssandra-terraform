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

# Variables to pass into the aws terraform aws modules
variable "name" {
  description = "The name to give the new Kubernetes cluster resources."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastrure being built."
  type        = string
}

variable "resource_owner" {
  description = "The name of the Project Owner"
  type        = string
  default     = "Datastax"
}

variable "region" {
  description = "The aws region in which resources will be defined."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of instance to be used in the k8ssandra."
  type        = string
  default     = "r5d.2xlarge"
}

# Expose Subnet Ssettings
variable "public_cidr_block" {
  description = "List of public subnet cidr blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_cidr_block" {
  description = "List of private subnet cidr blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

locals {
  # Name prefix will be used infront of every resource name.
  name_prefix = format("%s-%s", var.environment, var.name)

  # Common Tags to attach all the resources.
  tags = {
    "Environment"    = var.environment
    "resource-name"  = var.name
    "resource-owner" = var.resource_owner
    "project-id"     = format("%s", data.aws_caller_identity.current.id)
  }
}

data "aws_caller_identity" "current" {}
