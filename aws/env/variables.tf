variable "name" {
  description = "The name to give the new Kubernetes cluster resources."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastrure being built."
  type        = string
}

variable "region" {
  description = "The aws region in kwhich resources will be defined."
  type        = string
  default     = "us-east-1"
}

locals {
  name_prefix = format("%s-%s", var.environment, var.name)
}
