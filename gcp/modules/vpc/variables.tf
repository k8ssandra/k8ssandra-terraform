variable "name" {
  description = "name of the cluster "
}

variable "project_id" {
  description = "The project in which to hold the components"
  type        = string
}

variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
}


variable "cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  default     = "10.0.0.0/16"
  type        = string
}

variable "cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork netmask; an /16 network and a /20 subnetwork would be 4."
  type        = number
  default     = 4
}

variable "cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type."
  type        = number
  default     = 0
}

variable "secondary_cidr_block" {
  description = "The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  type        = string
  default     = "10.1.0.0/16"
}

variable "secondary_cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork's secondary range netmask; an /16 network and a /20 subnetwork would be 4."
  type        = number
  default     = 4
}

variable "secondary_cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type's secondary ranges."
  type        = number
  default     = 0
}

# Router variables
variable "enable_cloud_nat" {
  type        = bool
  default     = true
  description = "Whether to enable Cloud NAT. This can be used to allow private cluster nodes to accesss the internet. Defaults to 'true'"
}

variable "enable_cloud_nat_logging" {
  type        = bool
  default     = true
  description = " Whether the NAT should export logs. Defaults to 'true'."
}

variable "cloud_nat_logging_filter" {
  type        = string
  default     = "ERRORS_ONLY"
  description = " What filtering should be applied to logs for this NAT. Valid values are: 'ERRORS_ONLY', 'TRANSLATIONS_ONLY', 'ALL'. Defaults to 'ERRORS_ONLY'."
}
