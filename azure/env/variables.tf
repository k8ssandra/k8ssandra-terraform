variable "environment" {
  type        = string
  description = "name of the environment where infrastructure being built"
}

variable "name" {
  type        = string
  description = "AKS name in Azure"
}

variable "region" {
  description = "The location in which to create the resources."
  type        = string
}

variable "kubernetes_version" {
  description = "version of the kubernetes cluster"
  default     = "1.19.9"
  type        = string
}

variable "system_node_count" {
  description = "Number of AKS worker nodes"
  type        = number
  default     = 3
}

variable "public_subnet_prefixes" {
  description = "value"
  type        = list(string)
  default     = ["10.1.0.0/24"]
}

variable "private_subnet_prefixes" {
  description = "value"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "private_service_endpoints" {
  description = "private service endpoints"
  type        = list(string)
  default     = ["Microsoft.Storage"]
}

variable "public_service_endpoints" {
  description = "public service endpoints"
  type        = list(string)
  default     = []
}

locals {
  prefix = format("%s-%s", lower(var.environment), lower(var.name))
  
  tags = {
    "environment"     = var.environment
    "project_name"    = var.name
    "location"        = var.region
    "subscription_id" = data.azurerm_subscription.current.display_name
  }
}

data "azurerm_subscription" "current" {
}
