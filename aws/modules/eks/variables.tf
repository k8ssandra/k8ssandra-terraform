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

variable "region" {
  description = "The aws region in kwhich resources will be defined."
  type        = string
  default     = "us-east-1"
}

variable "subnet_ids" {
  description = "Subnet id to attach the eks cluster."
  type        = list(string)
  default     = []
}

variable "security_group_id" {
  description = "Security group id to configure eks cluster."
  type        = list(string)
  default     = []
}

variable "instance_profile_name" {
  description = "Instance profile name to attach aws lunch configuration."
  type        = string
}

locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks_cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks_cluster.certificate_authority[0].data}' '${var.name}'
USERDATA
}
