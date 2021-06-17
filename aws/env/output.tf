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

# eks module output attributes
#------------------------------
output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

# Version of the EKS cluster
output "cluster_version" {
  description = "Version of the EKS cluster"
  value       = module.eks.cluster_version
}

# The endpoint for your EKS Kubernetes API
output "cluster_Endpoint" {
  description = "The endpoint for your EKS Kubernetes API"
  value       = module.eks.cluster_Endpoint
}

# s3 module output attributes
#-----------------------------
# AWS s3 bucket id
output "bucket_id" {
  description = "Bucket Name (aka ID)"
  value       = module.s3.bucket_id
}

# Connect AWS cluster
output "connect_cluster" {
  description = "Configuring EKS cluster access for kubectl"
  value       = format("aws eks --region %s update-kubeconfig --name %s", var.region, module.eks.cluster_name)
}
