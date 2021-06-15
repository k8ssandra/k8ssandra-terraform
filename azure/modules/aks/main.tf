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

# Azure Kubernetes Cluster Service(AKS) configuration
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = format("%s-aks-cluster", var.name)
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.name

  # Configure default node pool, it is mandatory to configure this block.
  default_node_pool {
    # The node pool only allows name with 12 characters, does not allow any special characters. 
    name       = format("%spool", var.environment)
    node_count = var.node_count
    vm_size    = var.vm_size
    # The type of node pool which should be created. 
    type = "VirtualMachineScaleSets"
    # Route Table must be configured at this subnet.
    vnet_subnet_id     = var.private_subnet
    availability_zones = [1, 2, 3]
    # Enableing autoscaling requires that the type is set to "VirtualMachineScaleSets."
    enable_auto_scaling = true
    min_count           = var.min_count
    max_count           = var.max_count
    tags                = var.tags
  }

  identity {
    # The type of identity used for the manages cluster.
    type                      = "UserAssigned"
    user_assigned_identity_id = var.user_assigned_id
  }

  network_profile {
    load_balancer_sku = "Standard"
    # Network plugin to use for the networking, supported values "azure" and "Kubenet".
    # When the Network Plugin type set to azure the "vnet_subnet_id" feild in the default node pool must be set.
    network_plugin = var.network_plugin
    network_policy = "azure" # Sets Networkpolicy to be used with azure CNI.
    # following feild should all the set or should all be empty
    docker_bridge_cidr = var.docker_bridge_cidr
    dns_service_ip     = var.dns_service_ip
    # This range should not be used by any network element on or connected to thid "VNet".
    # It must be smaller then /12.
    service_cidr = var.service_cidr
  }

  lifecycle {
    # This life cycle policy to prevent the cluster being destroy. It set to false.
    prevent_destroy = false

    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = format("az aks get-credentials --resource-group %s --name %s-aks-cluster --overwrite-existing", var.resource_group_name, var.name)
  }

}
