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
  description = "Name of the environment where infrastructure being built."
  type        = string
}

variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
}

variable "project_id" {
  description = "The GCP project in which the components are created."
  type        = string
}

variable "zone" {
  description = "The zone in which to create the Kubernetes cluster. Must match the region"
  type        = string
  default     = "us-central-1a"
}

variable "k8s_namespace" {
  description = "The namespace to use for the deployment and workload identity binding"
  type        = string
  default     = "default"
}

variable "initial_node_count" {
  description = "Node count to define number of nodes per Zone, each region by default creates three nodes."
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Type of machines which are used by cluster node pool"
  type        = string
  default     = "e2-highmem-8"
}

variable "service_account_iam_roles" {
  type = list(string)

  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ]
  description = "List of the default IAM roles to attach to the service account on the GKE Nodes."
}

variable "service_account_custom_iam_roles" {
  type    = list(string)
  default = []

  description = <<-EOF
  List of arbitrary additional IAM roles to attach to the service account on
  the GKE nodes.
  EOF
}

variable "project_services" {
  type = list(string)

  default = [
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "sqladmin.googleapis.com",
    "securetoken.googleapis.com",
  ]
  description = "The GCP APIs that should be enabled in this project."
}

locals {
  prefix = format("%s-%s", lower(var.environment), lower(var.name))
}