# Common variables.
variable "location" {
  description = "Azure location where all the resources being created."
  type        = string
}

variable "name" {
  description = "Prifix of the all resource name."
  type        = string
}

variable "environment" {
  description = "The environment of the infrastructure being built."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

# Storage Account variables.
variable "account_tier" {
  description = "The Storage Acount tier."
  default     = "standard"
  type        = string
}

variable "replication_type" {
  description = "The Storage Account Repluucation type."
  default     = "LRS"
  type        = string
}
/*
# subnet id
variable "private_subnet" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
  type        = string
}
*/
# tags
variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(string)
  default     = {}
}
