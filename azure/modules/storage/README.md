# Terraform Azure cloud storage module 
This is a Dynamic modules in Terraform to create Azure Storage Account in a subnet.

* main.tf : contains all the resources which will be created with `terraform apply` command. 
* variables.tf : contains all variables required to create the resources.
* outputs.tf : contains output attributes of the resources. 

## Azure cloud resources created
* Azure Storage Account
    * Network profile( configured a subnet_id, let subnet resources will be able to communicate with the storage account privately.)
* Azure Storage Container

## Resource Naming Limitations
* Azure Storage Account only allows name with 24 characters long and letters and numbers, does not allow any special characters.
    * Format of storage account name `<environment>k8ssandrastorageaccount`.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | The Storage Acount tier. | `string` | `"standard"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location where all the resources being created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | The subnet id of the virtual network where the virtual machines will reside. | `string` | n/a | yes |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | The Storage Account Replication type. | `string` | `"LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | Azure Storage account id. |
| <a name="output_storage_container_id"></a> [storage\_container\_id](#output\_storage\_container\_id) | Azure storage container id |
