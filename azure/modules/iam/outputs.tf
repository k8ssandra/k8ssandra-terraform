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

# Output attribute of the Managed Identities
output "user_id" {
  description = "Azure Managed Identity id."
  value       = azurerm_user_assigned_identity.user_assigned_identity.id
}

output "principal_id" {
  description = "Azure Managed identity principal id."
  value       = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}

# Output attributes of the resource group
output "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  value       = azurerm_resource_group.resource_group.name
}

output "location" {
  description = "Azure location where all the resources being created."
  value       = azurerm_resource_group.resource_group.location
}
