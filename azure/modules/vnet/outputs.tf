output "virtual_network_id" {
  description = "The id of the newly created virtual_network"
  value       = azurerm_virtual_network.virtual_network.id
}

output "virtual_network_name" {
  description = "The Name of the newly created virtual_network"
  value       = azurerm_virtual_network.virtual_network.name
}

output "virtual_network_location" {
  description = "The location of the newly created virtual_network"
  value       = azurerm_virtual_network.virtual_network.location
}

output "virtual_network_address_space" {
  description = "The address space of the newly created virtual_network"
  value       = azurerm_virtual_network.virtual_network.address_space
}

output "public_subnets" {
  description = "The ids of subnets created inside the newl virtual_network"
  value       = azurerm_subnet.public_subnet.id
}

output "private_subnets" {
  description = "The ids of subnets created inside the newl virtual_network"
  value       = azurerm_subnet.private_subnet.id
}

