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

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
# Optional Variables
## Exposed VPC Settings
variable "vpc_instance_tenancy" {
  type    = string
  default = "default"
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = "true"
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = "true"
}

variable "vpc_enable_classiclink" {
  type    = bool
  default = "false"
}


# Expose Subnet Ssettings
variable "public_cidr_block" {
  type = list(string)
}
variable "private_cidr_block" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}


# Avilability Zones variables
variable "multi_az_nat_gateway" {
  description = "place a NAT gateway in each AZ"
  default     = 1
}

variable "single_nat_gateway" {
  description = "use a single NAT gateway to serve outbound traffic for all AZs"
  default     = 0
}

locals {
  pri_avilability_zones = slice(data.aws_availability_zones.availability_zones.names, 0, length(var.private_cidr_block))
  pub_avilability_zones = slice(data.aws_availability_zones.availability_zones.names, 0, length(var.public_cidr_block))

  pub_az_count = length(local.pub_avilability_zones)
  pri_az_count = length(local.pri_avilability_zones)

  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}
