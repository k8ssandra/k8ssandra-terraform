resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = format("%s-AKS-cluster", var.name)
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name

  default_node_pool {
    name                = format("%snodepool", var.environment) # only 12 charecters 
    node_count          = var.node_count
    vm_size             = var.vm_size
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = var.private_subnet
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = true
    min_count           = var.min_count
    max_count           = var.max_count
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku  = "Standard"
    network_plugin     = "azure" # CNI
    docker_bridge_cidr = var.docker_bridge_cidr
    dns_service_ip     = var.dns_service_ip
    service_cidr       = var.service_cidr
  }

  lifecycle {
    prevent_destroy = false

    create_before_destroy = true
  }

}
