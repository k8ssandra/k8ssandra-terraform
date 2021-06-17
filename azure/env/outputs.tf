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

# Output attribute of the Azure Kubernetes Cluster id.
output "aks_id" {
  description = "Azure kuberenetes service id."
  value = module.aks.azurerm_kubernetes_cluster_id
}

# Output attribute of the Azure Kubernetes Cluster fqdn.
output "aks_fqdn" {
  description = "Azure kuberenetes service fqdn."
  value = module.aks.azurerm_kubernetes_cluster_fqdn
}

# Output attribute of the Resource Group.
output "resource_group" {
  description = "The name of the resource group in which the resources will be created."
  value = module.iam.resource_group_name
}

# Output attribute of the Storage Account id.
output "storage_account_id" {
  description = "Azure Storage account id."
  value       = module.storage.storage_account_id
}

# connection string to connect you Azure Kubernetes cluster.
output "connect_cluster" {
  description = "Connection string to be used to configure kubectl."
  value          =  format("az aks get-credentials --resource-group %s --name %s", module.iam.resource_group_name, module.aks.azurerm_kubernetes_cluster_name)
}
