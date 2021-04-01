variable "name" {
  description = "name of the cluster"
}

variable "project" {
  description = "project ID"
  default     = ""
}

variable "location" {
  description = "name of the region"
  default     = "us-central1"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  description = "name of the machine_type"
  default     = "n1-standard-1"
}

variable "region" {
  description = "name of the region"
}

variable "network_link" {
  description = "network link"
  default     = ""
}

variable "subnetwork_link" {
  description = "subnetworking link"
  default     = ""
}

variable "service_account" {
  default = ""
}