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

# Variables to pass into the aws terraform modules.
variable "name" {
  description = "Name is the prefix to use for resources that needs to be created."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastructure is being built."
  type        = string
}

variable "resource_owner" {
  description = "The name of the Account Owner"
  type        = string
}

variable "region" {
  description = "The AWS region where terraform build resources."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of instance to be used for the Kubernetes cluster."
  type        = string
  default     = "r5d.2xlarge"
}

variable "desired_capacity" {
  description = "Desired capacity for the autoscaling Group."
  type        = number
  default     = 3
}

variable "max_size" {
  description = "Maximum number of the instances in autoscaling group"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum number of the instances in autoscaling group"
  type        = number
  default     = 3
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
