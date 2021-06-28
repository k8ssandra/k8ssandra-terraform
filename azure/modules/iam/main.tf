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

# Azure Resource group
resource "azurerm_resource_group" "resource_group" {
  name     = format("%s-resource-group", var.name)
  location = var.location
  tags     = var.tags
}
