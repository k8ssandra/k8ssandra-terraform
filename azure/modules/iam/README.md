# Azure Managed Identities module
This is a Dynamic module in Terraform to create Identities and policies. This module will be called from ../env/dev.tf modules file.

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
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_user_assigned_identity.user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location where all the resources being created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | Azure location where all the resources being created. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Azure Managed identity principal id. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group in which the resources will be created. |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | Azure Managed Identity id. |
