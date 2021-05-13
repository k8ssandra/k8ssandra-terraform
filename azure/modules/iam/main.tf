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

/*# Cluster Identity
resource "azuread_application" "application" {
  name = var.name
}

#service principal
resource "azuread_service_principal" "service_principal" {
  application_id = azuread_application.application.application_id
}


#random String 
resource "random_string" "cluster_sp_password" {
  length  = 32
  special = true
  keepers = {
    service_principal = azuread_service_principal.service_principal.id
  }
}

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = azuread_service_principal.service_principal.id
  value                = random_string.cluster_sp_password.result

  # 1 year since creation
  # https://www.terraform.io/docs/configuration/functions/timeadd.html
  end_date = timeadd(timestamp(), "8760h")

  lifecycle {
    ignore_changes = [end_date]
  }
}

data "azurerm_subscription" "subscription" {
}

data "azurerm_client_config" "client_config" {
}

resource "azurerm_role_definition" "role_definition" {
  role_definition_id = "00000000-0000-0000-0000-000000000000"
  name               = "my-custom-role-definition"
  scope              = data.azurerm_subscription.subscription.id

  permissions {
    actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read", "Microsoft.Storage/storageAccounts/blobServices/containers/write"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.subscription.id,
  ]
}

resource "azurerm_role_assignment" "role_assignment" {
  name               = "00000000-0000-0000-0000-000000000000"
  scope              = "Storage" # storage.id
  role_definition_id = azurerm_role_definition.role_definition.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}
*/

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  name = format("%s-user-identity", var.name)
  tags = var.tags
}

resource "azurerm_resource_group" "resource_group" {
  name     = format("%s-resource-group", var.name)
  location = var.location
  tags     = var.tags
}
