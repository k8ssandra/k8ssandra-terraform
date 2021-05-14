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

# Output attributes of Vnet resources. 
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

# Output attributes of the subnet ids.
output "public_subnets" {
  description = "The ids of subnets created inside the newl virtual_network"
  value       = azurerm_subnet.public_subnet.id
}

output "private_subnets" {
  description = "The ids of subnets created inside the newl virtual_network"
  value       = azurerm_subnet.private_subnet.id
}
