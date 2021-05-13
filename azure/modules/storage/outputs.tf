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

# Azure Kubernetes Cluster output attributes.
output "storage_account_id" {
  description = "Azure Storage account id."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_container_id" {
  description = "Azure storage container id"
  value       = azurerm_storage_container.storage_container.id
}

output "policy_id" {
  description = "subnet service storage endpoint policy id."
  value       = azurerm_subnet_service_endpoint_storage_policy.subnet_service_endpoint_policy.id
}
