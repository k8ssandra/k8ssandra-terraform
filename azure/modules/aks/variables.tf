variable "location" {
  description = "azure location to deploy resources"
}

variable "name" {
  description = "AKS cluster name"
}

variable "environment" {
  description = "AKS cluster environment"
}

variable "kubernetes_version" {
  description = "Version of the AKS cluster"
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy AKS cluster in"
}


variable "private_subnet" {
  description = "version of the kubernetes cluster"
}

variable "vm_size" {
  description = "size/type of VM to use for nodes"
  default     = "Standard_DS2_v2"
  type        = string
}

variable "node_count" {
  description = "number of nodes to deploy"
  default     = "3"
  type        = number
}

variable "min_count" {
  description = "Minimum Node Count"
  default     = 3
  type        = number
}
variable "max_count" {
  description = "Maximum Node Count"
  default     = 5
  type        = number
}

variable "docker_bridge_cidr" {
  description = "value"
  default     = "172.17.0.1/16"
}

variable "dns_service_ip" {
  description = "value"
  default     = "10.2.0.10"
}

variable "service_cidr" {
  description = "value"
  default     = "10.2.0.0/24"
}

variable "tags" {
  default = {}
}