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
  description = "Name is the prefix to use for resources that needs to be created."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastructure is being built."
  type        = string
}

variable "region" {
  description = "The AWS region in where terraform builds resources."
  type        = string
}

# Virtual Private Cloud CIDR block
variable "vpc_cidr_block" {
  description = "Virtual Private Cloud CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# Optional Variables
## Exposed VPC Settings.
variable "vpc_instance_tenancy" {
  type    = string
  default = "default"
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = "true"
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = "true"
}

variable "vpc_enable_classiclink" {
  type    = bool
  default = "false"
}


# Expose Subnet settings.
variable "public_cidr_block" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_cidr_block" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

# Common tags for the resources.
variable "tags" {
  description = "Common tags to attach all the resources create in this project."
  type        = map(string)
  default     = {}
}

# Allow workstation to communicate with the cluster API Server.
# This security group controls networking access to the Kubernetes masters. We configure this with an ingress rule to allow traffic from the worker nodes.
# Allow inbound traffic from your local workstation external IP to the Kubernetes.
variable "cluster_api_cidr" {
  description = "Allow workstation to communicate with the cluster API Server"
  type        = string
  default     = "10.2.0.0/32"
}

# Avilability Zones variables.
# Create a NAT gateway in each avilability zone to ensure a zone independent architecture.
variable "multi_az_nat_gateway" {
  description = "place a NAT gateway in each AZ"
  default     = 1
}

# By default we are using multiple NAT gateways for high avilablility, and zone independent architecture.
variable "single_nat_gateway" {
  description = "use a single NAT gateway to serve outbound traffic for all AZs"
  default     = 0
}

locals {
  # Query on Data to pick up avilability zone automatically based on the length cidr blocks. 
  pri_avilability_zones = slice(data.aws_availability_zones.availability_zones.names, 0, length(var.private_cidr_block))
  pub_avilability_zones = slice(data.aws_availability_zones.availability_zones.names, 0, length(var.public_cidr_block))

  # Set local variables number of avilability zones based on the query results.
  pub_az_count = length(local.pub_avilability_zones)
  pri_az_count = length(local.pri_avilability_zones)

}

# This data block help you to get the avilability zone from the region.
data "aws_availability_zones" "availability_zones" {
}
