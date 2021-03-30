variable "name" {
  description = "name of the cluster "
}

variable "project_services" {
  description = "project services"
  type        = list(string)
  default     = []
}

variable "project_id" {
  description = "The project in which to hold the components"
  type        = string
}

variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
}