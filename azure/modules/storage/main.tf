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

# Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  name = format("%sk8ssandrastorage", var.environment)
  # Storage account name only allows 24 character long, and doesn't allow any special characters. 
  resource_group_name = var.resource_group_name
  location            = var.location
  # Account tier type defaulted to standard. 
  account_tier = var.account_tier
  # Account replication type Locally redundant storage(LRS)
  account_replication_type = var.replication_type


  tags = var.tags
}

# Azure subnet Service endpoint storage policy to let Kubernetes cluster nodes to communicate with the storage account.
resource "azurerm_subnet_service_endpoint_storage_policy" "subnet_service_endpoint_policy" {
  name                = format("%s-storage-policy", var.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  definition {
    name        = format("%s-storage-policy1", var.name)
    description = "subnet service endpoint storage policy"
    service_resources = [
      azurerm_storage_account.storage_account.id
    ]
  }

  depends_on = [
    azurerm_storage_account.storage_account,
    azurerm_storage_container.storage_container
  ]

  tags = var.tags
}

# Azure Storage Container
resource "azurerm_storage_container" "storage_container" {
  name                 = format("%s-storage-container", var.name)
  storage_account_name = azurerm_storage_account.storage_account.name
  # Storge container access type is private always.
  container_access_type = "private"
}
