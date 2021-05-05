variable "environment" {
  type        = string
  description = "name of the environment where infrastructure being built"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
}

variable "name" {
  type        = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
