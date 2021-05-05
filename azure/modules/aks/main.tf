resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name               = "system"
    node_count         = var.system_node_count
    vm_size            = "Standard_DS2_v2"
    type               = "VirtualMachineScaleSets"
    availability_zones = [1, 2, 3]

    enable_auto_scaling = true
    min_count           = var.min_count
    max_count           = var.max_count
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" # CNI
  }

  lifecycle {
    prevent_destroy = true
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_cluster_node_pool" {
  name                  = format("%s-node-pool", var.name)
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id
  vm_size               = "Standard_DS2_v2"
  node_count            = var.system_node_count

  tags = var.tags
}
