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
output "azurerm_kubernetes_cluster_id" {
  description = "Azure Kubernetes cluster id"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "azurerm_kubernetes_cluster_name" {
  description = "Azure Kubernetes cluster resource name."
  value       = format("%s-aks-cluster", var.name)
}

output "azurerm_kubernetes_cluster_fqdn" {
  description = "Azure Kubernetes cluster fqdn."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.fqdn
}
