variable "name" {
  description = "name of the cluster"
  type        = string
}

variable "project_id" {
  description = "The project in which to hold the components"
  type        = string
}

variable "service_account_custom_iam_roles" {
  description = "service account custom iam roles"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
}

variable "service_account_iam_roles" {
  description = "service account custom iam roles"
  type        = list(string)
}
