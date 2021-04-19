variable "name" {
  description = "The name to give the new Kubernetes cluster resources."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastrure being built."
  type        = string
}

variable "resource_owner" {
  type    = string
  default = "Datastax"
}

variable "region" {
  description = "The aws region in kwhich resources will be defined."
  type        = string
  default     = "us-east-1"
}

# Expose Subnet Ssettings
variable "public_cidr_block" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_cidr_block" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

locals {
  name_prefix = format("%s-%s", var.environment, var.name)

  tags = {
    "Environment"    = var.environment
    "resource-name"  = var.name
    "resource-owner" = var.resource_owner
    "account-id"     = data.aws_caller_identity.current.account_id
  }
}

data "aws_caller_identity" "current" {}