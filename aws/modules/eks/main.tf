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

# Elastic kubernetes Service Cluster configuration
resource "aws_eks_cluster" "eks_cluster" {
  name     = format("%s-eks-cluster", var.name)
  role_arn = var.role_arn
  version  = var.cluster_version
  vpc_config {
    security_group_ids = [var.security_group_id] // from the vpc module
    subnet_ids         = var.subnet_ids          // from the vpc module
  }

  tags = var.tags

  provisioner "local-exec" {
    command = format("aws eks --region %s update-kubeconfig --name %s", var.region, aws_eks_cluster.eks_cluster.name)
  }

}

# AWS EKS node group configuration. 
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = format("%s-node-group", var.name)
  node_role_arn   = var.worker_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }
  depends_on = [
    aws_eks_cluster.eks_cluster
  ]

  tags = merge(var.tags, {
    "Name"                                                   = format("%s-node-group", var.name)
    format("kubernetes.io/cluster/%s-eks-cluster", var.name) = "owned"
    }
  )

  labels = {
    "key" = format("%s", aws_eks_cluster.eks_cluster.name)
  }
}
