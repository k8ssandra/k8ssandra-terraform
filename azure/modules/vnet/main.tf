# Copyright 2021 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Azure Virtual Network
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

# Azure Subnets
######################
## Public subnet
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

resource "azurerm_subnet" "appgw_subnet" {
  name                 = format("%s-appgw-subnet", var.name)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.app_gateway_subnet_address_prefix

  lifecycle {
    create_before_destroy = true
  }
}


## Private Subnet
resource "azurerm_subnet" "private_subnet" {
  name                 = format("%s-private-subnet", var.name)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = var.private_subnet_prefixes
  service_endpoints    = var.private_service_endpoints

  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
  # Storage account endpoint id.
  service_endpoint_policy_ids = [var.policy_id]

  lifecycle {
    create_before_destroy = true
  }

}

# Azure Network Security Group
resource "azurerm_network_security_group" "ssh_network_security_group" {
  name                = format("%s-ssh", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  security_rule {
    name                       = format("%s-ssh-security-rule", var.name)
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

# Azure subnet network security group association
resource "azurerm_subnet_network_security_group_association" "subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.ssh_network_security_group.id
}

# Azure public route table.
resource "azurerm_route_table" "public_route_table" {
  name                = format("%s-public-route-table", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Azure public route 
resource "azurerm_route" "public_route" {
  name                = format("%s-public_route", var.name)
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.public_route_table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

# Azure private route table
resource "azurerm_route_table" "private_route_table" {
  name                = format("%s-private-route-table", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Azure private route.
resource "azurerm_route" "private_route" {
  name                = format("%s-private_route", var.name)
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.private_route_table.name
  address_prefix      = azurerm_subnet.private_subnet.address_prefix
  next_hop_type       = "VnetLocal"
}

# Azure subnet route table association.
resource "azurerm_subnet_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = azurerm_subnet.public_subnet.id
  route_table_id = azurerm_route_table.public_route_table.id
}

# Private subnet route table association.
resource "azurerm_subnet_route_table_association" "private_subnet_route_table_association" {
  subnet_id      = azurerm_subnet.private_subnet.id
  route_table_id = azurerm_route_table.private_route_table.id
}

# Network watcher couldn't be able to create.
##################
/*resource "azurerm_network_watcher" "network_watcher" {
  name                = format("%s-azure-network-watcher", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}
*/

# Public Ip 
resource "azurerm_public_ip" "appgw_public_ip" {
  name                = format("%s-appgw-public-ip", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

# Azure public IP adress to attach NAT gateway
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

# NAT gateway public IP association.
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.public_ip.id
}

# Azure subnet NAT gateway association.
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  subnet_id      = azurerm_subnet.public_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

resource "azurerm_application_gateway" "application_gateway" {
  name                = format("%s-application-Gateway", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.app_gateway_sku
    tier     = var.app_gateway_tier
    capacity = 2
  }

  gateway_ip_configuration {
    name      = format("%s-appGatewayIpConfig", var.environment)
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = format("%s-fornt_end_port", var.environment)
    port = 80
  }

  frontend_port {
    name = format("%s-httpsPort", var.environment)
    port = 443
  }

  frontend_ip_configuration {
    name                 = format("%s-frontend_ip_configuration", var.environment)
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  backend_address_pool {
    name = format("%s-backend_address_pool", var.environment)
  }

  backend_http_settings {
    name                  = format("%s-backend_http_setting", var.environment)
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = format("%s-http-listener", var.environment)
    frontend_ip_configuration_name = format("%s-frontend_ip_configuration", var.environment)
    frontend_port_name             = format("%s-fornt_end_port", var.environment)
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = format("%s-request_routing_rule_name", var.environment)
    rule_type                  = "Basic"
    http_listener_name         = format("%s-http-listener", var.environment)
    backend_address_pool_name  = format("%s-backend_address_pool", var.environment)
    backend_http_settings_name = format("%s-backend_http_setting", var.environment)
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.virtual_network, azurerm_public_ip.appgw_public_ip, azurerm_subnet.appgw_subnet]
}
