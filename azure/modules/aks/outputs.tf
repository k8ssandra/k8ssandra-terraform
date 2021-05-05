output "azurerm_kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "azurerm_kubernetes_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.fqdn
}

output "resource_group" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.node_resource_group
}
