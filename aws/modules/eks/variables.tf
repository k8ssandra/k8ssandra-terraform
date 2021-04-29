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
  description = "The name to give the new Kubernetes cluster resources."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastrure being built."
  type        = string
}

variable "role_arn" {
  description = "Iam role arn to attach the EKS cluster."
  type        = string
}

variable "worker_role_arn" {
  description = "Iam worker role arn to attach the EKS cluster."
  type        = string
}

variable "region" {
  description = "The aws region in kwhich resources will be defined."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet id to attach the eks cluster."
}

variable "security_group_id" {
  description = "Security group id to configure eks cluster."
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets to create the resources."
}

variable "tags" {
  description = "Common tags to attach all the resources create in this project."
  type        = map(string)
}

variable "instance_profile_name" {
  description = "Instance profile name to attach aws lunch configuration."
  type        = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster."
  type        = string
  default     = "1.19"
}

variable "instance_type" {
  description = "Type of instance to be used in the k8ssandra."
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the autoscaling Group."
  type        = string
  default     = "3"
}

variable "max_size" {
  description = "Maximum number of the instances in autoscaling group"
  type        = string
  default     = "5"
}

variable "min_size" {
  description = "Minimum number of the instances in autoscaling group"
  type        = string
  default     = "3"
}

locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks_cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks_cluster.certificate_authority[0].data}' '${var.name}'
USERDATA

}
