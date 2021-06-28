# AKS Clusters Terraform Module
This is a Dynamic module in terraform to create GKE cluster. This module will be called from ../env/dev.tf modules file, by using this reusable module we will be able to create AKS cluster and Cluster default node pool.

* main.tf : contains all the resources which will be created with `terraform apply` command.
* variables.tf : contains all the variables required to create the resources.
* outputs.tf : prints output attributes of the resources.

## Azure cloud resources created
* AKS cluster
* Default node pool
    * AKS cluster is required to configure the default node pool.

## Resource Naming Limitations
* The AKS cluster default node pool only allows name with 12 characters long, does not allow any special characters.
    * Format of node pool name `<environment>nodepool`.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | CNI DNS service IP | `string` | `"10.2.0.10"` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | CNI Docker bridge CIDR | `string` | `"172.17.0.1/16"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of the AKS cluster. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location where all the resources being created. | `string` | n/a | yes |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | Maximum Node Count | `number` | n\a | yes |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | Minimum Node Count | `number` | n\a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin type | `string` | `"azure"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of nodes to deploy | `number` | n\a | yes |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | The subnet id of the virtual network where the virtual machines will reside. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CNI service CIDR | `string` | `"10.2.0.0/24"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | `{}` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Specifies the size of the virtual machine. | `string` | `"Standard_DS2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_kubernetes_cluster_fqdn"></a> [azurerm\_kubernetes\_cluster\_fqdn](#output\_azurerm\_kubernetes\_cluster\_fqdn) | Azure Kubernetes cluster fqdn. |
| <a name="output_azurerm_kubernetes_cluster_id"></a> [azurerm\_kubernetes\_cluster\_id](#output\_azurerm\_kubernetes\_cluster\_id) | Azure Kubernetes cluster id |
| <a name="output_azurerm_kubernetes_cluster_name"></a> [azurerm\_kubernetes\_cluster\_name](#output\_azurerm\_kubernetes\_cluster\_name) | Azure Kubernetes cluster name. |
