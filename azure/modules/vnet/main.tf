# 
resource "azurerm_virtual_network" "virtual_network" {
  name                = format("%s-vnet", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_subnet" "public_subnet" {
  name                 = format("%s-public-subnet", var.name)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.public_subnet_prefixes
  service_endpoints    = var.public_service_endpoints

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_subnet" "private_subnet" {
  name                 = format("%s-private-subnet", var.name)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.private_subnet_prefixes
  service_endpoints    = var.private_service_endpoints

  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true

  lifecycle {
    create_before_destroy = true
  }

}


resource "azurerm_network_security_group" "ssh_network_security_group" {
  name                = format("%s-ssh", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  security_rule {
    name                       = "ssh-security-rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.ssh_network_security_group.id
}

resource "azurerm_route_table" "public_route_table" {
  name                = format("%s-public-route-table", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_route" "public_route" {
  name                = format("%s-public_route", var.name)
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.public_route_table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}


resource "azurerm_route_table" "private_route_table" {
  name                = format("%s-private-route-table", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_route" "private_route" {
  name                = format("%s-private_route", var.name)
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.private_route_table.name
  address_prefix      = azurerm_subnet.private_subnet.address_prefix
  next_hop_type       = "VnetLocal"
}

resource "azurerm_subnet_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = azurerm_subnet.public_subnet.id
  route_table_id = azurerm_route_table.public_route_table.id
}

# Private Route table associations
resource "azurerm_subnet_route_table_association" "private_subnet_route_table_association" {
  subnet_id      = azurerm_subnet.private_subnet.id
  route_table_id = azurerm_route_table.private_route_table.id
}

# Network watcher
##################
/*resource "azurerm_network_watcher" "network_watcher" {
  name                = format("%s-azure-network-watcher", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}
*/
# Azure public ip firewall
resource "azurerm_public_ip" "public_ip" {
  name                = format("%s-public-ip", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# NAT gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = format("%s-nat-Gateway", var.name)
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  subnet_id      = azurerm_subnet.public_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
