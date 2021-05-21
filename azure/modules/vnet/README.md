# Azure Virtual Network
This is a Dynamic module in Terraform to create Virtual Network(Vnet). This module will be called from the ./env/dev.tf file. 

* main.tf : contains all the resources, which will be created with `terraform apply` command.
* variables.tf : contains all the variables required to create the resources.
* outputs.tf : print output attributes of the resources.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.nat_gateway_public_ip_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_security_group.ssh_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_route.private_route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route.public_route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.subnet_nat_gateway_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.subnet_network_security_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.private_subnet_route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.public_subnet_route_table_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. | `list(string)` | <pre>[<br>  "10.1.0.0/16"<br>]</pre> | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | The DNS servers to be used with vNet. | `list(string)` | `[]` | no |
| <a name="input_endpoint_network_policies"></a> [endpoint\_network\_policies](#input\_endpoint\_network\_policies) | A map of subnet name to enable/disable private link endpoint network policies on the subnet. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location where all the resources being created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids) | A map of subnet name to Network Security Group IDs | `map(string)` | `{}` | no |
| <a name="input_policy_id"></a> [policy\_id](#input\_policy\_id) | subnet service storage endpoint policy id. | `string` | n/a | yes |
| <a name="input_private_service_endpoints"></a> [private\_service\_endpoints](#input\_private\_service\_endpoints) | A map of subnet name to service endpoints to add to the subnet. | `list(string)` | `[]` | no |
| <a name="input_private_subnet_prefixes"></a> [private\_subnet\_prefixes](#input\_private\_subnet\_prefixes) | The address prefix to use for the subnet. | `list(string)` | n/a | yes |
| <a name="input_public_service_endpoints"></a> [public\_service\_endpoints](#input\_public\_service\_endpoints) | A map of subnet name to service endpoints to add to the subnet. | `list(string)` | `[]` | no |
| <a name="input_public_subnet_prefixes"></a> [public\_subnet\_prefixes](#input\_public\_subnet\_prefixes) | The address prefix to use for the subnet. | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_service_network_policies"></a> [service\_network\_policies](#input\_service\_network\_policies) | A map of subnet name to enable/disable private link service network policies on the subnet. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with your network and subnets. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The ids of subnets created inside the newl virtual\_network |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | The ids of subnets created inside the newl virtual\_network |
| <a name="output_virtual_network_address_space"></a> [virtual\_network\_address\_space](#output\_virtual\_network\_address\_space) | The address space of the newly created virtual\_network |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The id of the newly created virtual\_network |
| <a name="output_virtual_network_location"></a> [virtual\_network\_location](#output\_virtual\_network\_location) | The location of the newly created virtual\_network |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The Name of the newly created virtual\_network |
