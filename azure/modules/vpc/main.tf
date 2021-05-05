## Azure virtuval network
resource "azurerm_virtual_network" "virtual_network" {
  name                = format("%s-vnet", var.name)
  address_space       = [var.address_space]
  resource_group_name = var.resource_group_name
  location            = var.location
  #dns_servers         = [var.dns_servers]

  tags = var.tags
}

# Azure public subnet
resource "azurerm_subnet" "public_subnet" {
  count = length(var.public_subnets)

  resource_group_name = local.resource_group_name

  name                 = format("%s-public-subnet-%d", var.name, count.index)
  address_prefix       = element(var.public_subnets, count.index)
  virtual_network_name = local.virtual_network_name

  service_endpoints = [var.public_subnets_service_endpoints]

  lifecycle {
    create_before_destroy = true
  }
}

# Azure private subnet
resource "azurerm_subnet" "private_subnet" {
  count = length(var.private_subnets)

  resource_group_name = local.resource_group_name

  name                 = format("%s-private-subnet-%d", var.name, count.index)
  address_prefix       = element(var.private_subnets, count.index)
  virtual_network_name = local.virtual_network_name

  service_endpoints = [var.private_subnets_service_endpoints]

  lifecycle {
    create_before_destroy = true
  }
}

# Virtual Network Gateway, If there is non vpn this resource not required.
resource "azurerm_subnet" "gateway_subnet" {
  count = var.create_network && var.create_vnet_gateway ? 1 : 0

  name                 = "GatewaySubnet"
  resource_group_name  = local.resource_group_name
  address_prefix       = var.vnet_gateway_subnet_address_prefix
  virtual_network_name = local.virtual_network_name

  lifecycle {
    create_before_destroy = true
  }
}


# Public Route tables
resource "azurerm_route_table" "public_route_table" {

  resource_group_name = local.resource_group_name
  location            = local.location

  name                          = format("%s-public-route-table", var.name)
  disable_bgp_route_propagation = true

  tags = merge(var.tags, {
    "Name" = format("%s-public-route-table", var.name)
  })
}

# Private route table
resource "azurerm_route_table" "private_route_table" {
  count = length(var.private_subnets)

  resource_group_name = local.resource_group_name
  location            = local.location

  name                          = format("%s-private-route-table", var.name)
  disable_bgp_route_propagation = true

  tags = merge(var.tags, {
    "Name" = format("%s-private-route-table", var.name)
  })
}

# Public routes
resource "azurerm_route" "public_route" {
  resource_group_name = local.resource_group_name

  name             = format("%s-public-route-%s", var.name, lower(var.public_internet_route_next_hop_type))
  route_table_name = azurerm_route_table.public_route_table.name
  address_prefix   = "0.0.0.0/0"
  next_hop_type    = var.public_internet_route_next_hop_type
}

/*
# Public Routes
resource "azurerm_route" "public_internet_route" {
  resource_group_name = local.resource_group_name

  name                   = format("%s-public-internet-route-%s", var.name, lower(var.public_internet_route_next_hop_type))
  route_table_name       = azurerm_route_table.public_route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = var.public_internet_route_next_hop_type
  next_hop_in_ip_address = lower(var.public_internet_route_next_hop_in_ip_address) == lower("AzureFirewall") ? element(concat(azurerm_firewall.this.*.ip_configuration.0.private_ip_address, list("")), 0) : var.public_internet_route_next_hop_in_ip_address
}
*/
# private routes
# Allow access to Virtual network
resource "azurerm_route" "private_route" {
  count = length(var.private_subnets)

  resource_group_name = local.resource_group_name

  name             = format("%s-private-route", var.name)
  route_table_name = azurerm_route_table.private_route_table.name
  address_prefix   = element(var.address_spaces, 0)
  next_hop_type    = "VnetLocal"
}

# Route table associations
resource "azurerm_subnet_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = element(azurerm_subnet.public_subnet.*.id, count.index)
  route_table_id = azurerm_route_table.public_route_table.id
}

# Private Route table associations
resource "azurerm_subnet_route_table_association" "private_subnet_route_table_association" {
  count = length(var.private_subnets)

  subnet_id      = element(azurerm_subnet.private_subnet.*.id, count.index)
  route_table_id = element(azurerm_route_table.private_route_table.*.id, count.index)
}
/*
# Public Network security Group
resource "azurerm_network_security_group" "public_network_security_group" {
  count = length(var.public_subnets)

  name                = format("%s-public", var.name)
  location            = local.location
  resource_group_name = local.resource_group_name

  tags = merge(var.tags, {
    "Name" = format("%s-public", var.name)
  })
}
*/
# Private Network security group
resource "azurerm_network_security_group" "private_network_security_group" {
  count = length(var.private_subnets)

  name                = format("%s-private", var.name)
  location            = local.location
  resource_group_name = local.resource_group_name

  tags = merge(var.tags, {
    "Name" = format("%s-private", var.name)
  })
}

/*# Public Network security Group associations
resource "azurerm_subnet_network_security_group_association" "public_subnet_network_security_group_association" {
  count = length(var.public_subnets)

  subnet_id                 = element(azurerm_subnet.public_subnet.*.id, count.index)
  network_security_group_id = element(azurerm_network_security_group.public_network_security_group.*.id, 0)
}
*/
# Private Network network security group
resource "azurerm_subnet_network_security_group_association" "private_subnet_network_security_group_association" {
  count = length(var.private_subnets)

  subnet_id                 = element(azurerm_subnet.private_subnet.*.id, count.index)
  network_security_group_id = element(azurerm_network_security_group.private_network_security_group.*.id, 0)
}

# Network watcher
##################
resource "azurerm_network_watcher" "network_watcher" {
  count = var.create_network && var.create_network_watcher ? 1 : 0

  name                = format("%s-azure-network-watcher", var.name)
  location            = local.location
  resource_group_name = local.resource_group_name

  tags = merge(var.tags, {
    Name = format("%s-azure-network-watcher", var.name)
  })
}


# Subnet Firewall
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = local.resource_group_name
  address_prefix       = var.firewall_subnet_address_prefix
  virtual_network_name = local.virtual_network_name

  lifecycle {
    create_before_destroy = true
  }
}


# Azure public ip firewall
resource "azurerm_public_ip" "firewall_public_ip" {
  name                = format("%s-firewall-public-ip", var.name)
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(var.tags, {
    "Name" = format("%s-firewall-public-ip", var.name)
  })
}

# Azure Firewall
resource "azurerm_firewall" "firewall" {
  name                = format("%s-firewall", var.name)
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name      = format("%s-firewall", var.name)
    subnet_id = azurerm_subnet.firewall_subnet.id

    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }

  tags = merge(var.tags, {
    "Name" = format("%s-firewall", var.name)
  })
}

# firewall public ip prefix
resource "azurerm_public_ip_prefix" "firewall_public_ip_prefix" {
  name                = "nat-gateway-publicIPPrefix"
  location            = var.location
  resource_group_name = var.resource_group_name
  prefix_length       = 30 # defaulted to 30.
  zones               = [length(var.private_subnet)]
}

# NAT gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = format("%s-nat-Gateway", var.name)
  location                = var.location
  resource_group_name     = var.resource_group_name
  public_ip_address_ids   = [azurerm_public_ip.firewall_public_ip.id]
  public_ip_prefix_ids    = [azurerm_public_ip_prefix.firewall_public_ip_prefix.id]
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = [length(var.private_subnet)]
}
