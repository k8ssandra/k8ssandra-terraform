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

# Azure User assigned identity
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  name = format("%s-user-identity", var.name)
  tags = var.tags
}

data "azuread_service_principal" "service_principal" {
  display_name = "k8ssandra-terraform"
}

# Azure Resource group
resource "azurerm_resource_group" "resource_group" {
  name     = format("%s-resource-group", var.name)
  location = var.location
  tags     = var.tags
}

resource "azurerm_role_assignment" "network_role_assignment" {
  scope                = var.public_subnet
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.service_principal.object_id
}

resource "azurerm_role_assignment" "Operator_role_assignment" {
  scope                = azurerm_user_assigned_identity.user_assigned_identity.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azuread_service_principal.service_principal.object_id
  depends_on           = [azurerm_user_assigned_identity.user_assigned_identity]
}

resource "azurerm_role_assignment" "contributor_role_assignment" {
  scope                = var.appgw_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  depends_on           = [azurerm_user_assigned_identity.user_assigned_identity]
}

resource "azurerm_role_assignment" "reader_role_assignment" {
  scope                = azurerm_resource_group.resource_group.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  depends_on           = [azurerm_user_assigned_identity.user_assigned_identity]
}
