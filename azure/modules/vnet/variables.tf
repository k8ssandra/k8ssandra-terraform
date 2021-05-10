variable "name" {
  description = "Name of the vnet to create"
  type        = string
}

variable "location" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.1.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "public_subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}

variable "private_subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}

variable "public_service_endpoints" {
  description = "A map of subnet name to service endpoints to add to the subnet."
  type        = list(string)
  default     = []
}

variable "private_service_endpoints" {
  description = "A map of subnet name to service endpoints to add to the subnet."
  type        = list(string)
  default     = []
}

variable "endpoint_network_policies" {
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
  type        = bool
  default     = true
}

variable "service_network_policies" {
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
  type        = bool
  default     = true 
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
}