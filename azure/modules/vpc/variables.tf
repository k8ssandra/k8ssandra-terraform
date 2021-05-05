variable "name" {
  description = "Prefix of the all resource names"
  type        = string
}

variable "subnet_name" {
  description = "name to give the subnet"
  default     = "datastax-subnet"
}

variable "resource_group" {
  description = "resource group that the vnet resides in"
  type        = string
}

variable "subnet_cidr" {
  description = "the subnet cidr range"
}

variable "location" {
  description = "the cluster location"
}

variable "address_space" {
  description = "Network address space"
}

variable "create_network" {
  description = "Controls if networking resources should be created (it affects almost all resources)"
  default     = true
}

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
}

variable "create_network_security_group" {
  description = "Whether to create network security group"
  default     = true
}

variable "create_network_watcher" {
  description = "Whether to create network watcher"
  default     = true
}

variable "create_firewall" {
  description = "Whether to create firewall (incl. subnet and public IP))"
  default     = false
}

variable "create_vnet_gateway" {
  description = "Whether to create virtual network gateway (incl. subnet and public IP))"
  default     = false
}

variable "resource_group_name" {
  description = "Name to be used on resource group"
  default     = ""
}

variable "network_security_group_name" {
  description = "Name to be used on network security group"
  default     = ""
}

variable "location" {
  description = "Location where resource should be created"
  default     = ""
}

variable "name" {
  description = "Name to use on resources"
  default     = ""
}

variable "address_spaces" {
  description = "List of address spaces to use for virtual network"
  default     = []
}

variable "dns_servers" {
  description = "List of dns servers to use for virtual network"
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside virtual network"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside virtual network"
  default     = []
}

variable "aci_subnets" {
  description = "A list of Azure Container Instances (ACI) subnets inside virtual network"
  default     = []
}

variable "firewall_subnet_address_prefix" {
  description = "Address prefix to use on firewall subnet. Default is a valid value, which should be overriden."
  default     = "0.0.0.0/0"
}

variable "vnet_gateway_subnet_address_prefix" {
  description = "Address prefix to use on virtual network gateway subnet. Default is a valid value, which should be overriden."
  default     = "0.0.0.0/0"
}

variable "public_subnets_service_endpoints" {
  description = "The list of Service endpoints to associate with the public subnets. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql and Microsoft.Storage."
  default     = ["Microsoft.AzureActiveDirectory", "Microsoft.Storage" ]
}

variable "private_subnets_service_endpoints" {
  description = "The list of Service endpoints to associate with the private subnets. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql and Microsoft.Storage."
  default     = ["Microsoft.Storage"]
}

variable "aci_subnets_service_endpoints" {
  description = "The list of Service endpoints to associate with the ACI subnets. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql and Microsoft.Storage."
  default     = []
}

variable "public_route_table_disable_bgp_route_propagation" {
  description = "Boolean flag which controls propagation of routes learned by BGP on public route table. True means disable."
  default     = false
}

variable "private_route_table_disable_bgp_route_propagation" {
  description = "Boolean flag which controls propagation of routes learned by BGP on private route table. True means disable."
  default     = false
}

variable "public_internet_route_next_hop_type" {
  # More info: https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview
  description = "The type of Azure hop the packet should be sent when reaching 0.0.0.0/0 for the public subnets. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None."
  default     = "Internet"
}

variable "public_internet_route_next_hop_in_ip_address" {
  # More info: https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview
  description = "Contains the IP address packets should be forwarded to when destination is 0.0.0.0/0 for the public subnets. Next hop values are only allowed in routes where the next hop type is VirtualAppliance."
  default     = ""
}

variable "vnet_gateway_type" {
  description = "The type of the Virtual Network Gateway. Valid options are Vpn or ExpressRoute."
  default     = "Vpn"
}

variable "vnet_gateway_vpn_type" {
  description = "The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased."
  default     = "RouteBased"
}

variable "vnet_gateway_active_active" {
  description = "If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created."
  default     = false
}

variable "vnet_gateway_enable_bgp" {
  description = "If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway."
  default     = false
}

variable "vnet_gateway_sku" {
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2 and VpnGw3 and depend on the type and vpn_type arguments. A PolicyBased gateway only supports the Basic sku. Further, the UltraPerformance sku is only supported by an ExpressRoute gateway."
  default     = "Basic"
}

variable "vnet_gateway_bgp_settings" {
  description = "List of map containing BGP settings. Keys are: asn - (Optional) The Autonomous System Number (ASN) to use as part of the BGP; peering_address - (Optional) The BGP peer IP address of the virtual network gateway. This address is needed to configure the created gateway as a BGP Peer on the on-premises VPN devices. The IP address must be part of the subnet of the Virtual Network Gateway. Changing this forces a new resource to be created.; peer_weight - (Optional) The weight added to routes which have been learned through BGP peering. Valid values can be between 0 and 100."

  default = [{
    asn = 65515
  }]
}

variable "vnet_gateway_default_local_network_gateway_id" {
  description = "The ID of the local network gateway through which outbound Internet traffic from the virtual network in which the gateway is created will be routed (forced tunneling). Refer to the Azure documentation on forced tunneling. If not specified, forced tunneling is disabled."
  default     = ""
}

variable "vnet_gateway_vpn_client_configuration_address_space" {
  description = "The address space out of which ip addresses for vpn clients will be taken. You can provide more than one address space, e.g. in CIDR notation."
  default     = ["0.0.0.0/0"]
}

variable "vnet_gateway_vpn_client_configuration_root_certificate" {
  description = "One or more root_certificate blocks which are defined below. These root certificates are used to sign the client certificate used by the VPN clients to connect to the gateway. Type - list of maps, where keys are: name - (Required) A user-defined name of the root certificate; public_cert_data - (Required) The public certificate of the root certificate authority. The certificate must be provided in Base-64 encoded X.509 format (PEM). In particular, this argument must not include the -----BEGIN CERTIFICATE----- or -----END CERTIFICATE----- markers."
  default     = []
}

variable "vnet_gateway_vpn_client_configuration_revoked_certificate" {
  description = "One or more revoked_certificate blocks which are defined below. Type - list of maps, where keys are: name - (Required) A user-defined name of the revoked certificate.; thumbprint - (Required) The SHA1 thumbprint of the certificate to be revoked."
  default     = []
}

variable "vnet_gateway_vpn_client_configuration_vpn_client_protocols" {
  description = "List of the protocols supported by the vpn client. The supported values are SSTP, IkeV2 and OpenVPN."
  default     = [""]
}

# Tags

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
