# Terraform Azure Modules Folder

All the module calls made from this folder from dev.tf file. 

* This folder contains following files
  * dev.tf (modules file )
  * backend.tf ( contains backend configuration of the terraform, which contains terraform state files).
  * outputs.tf ( output's of the resource attributes after terraform apply)
  * version.tf ( contains terraform version and cloud provider version)
  * variables.tf (all the variable which required by the terraform modules.)

## What is a module?
A [Terraform Module](https://www.terraform.io/docs/language/modules/develop/index.html) is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such as a database or server cluster. Each Module is written using a combination of Terraform and scripts (mostly bash) and include automated tests, documentation, and examples.

* Every module has:
  * Input variables: to accept values from the calling module.
  * Output values: to return results to the calling module, which it can then use to populate arguments elsewhere.
  * Resources: to define one or more infrastructure objects that the module will manage.
  * Source: A source can be any local folder path or remote module located in source control systems like git.

## AKS cluster module example Usage.
Usage: The following module call will create AKS cluster and cluster node pool resources. Resources will be configured by using the following input variables on this module.

```
# Azure Kubernetes service module.
module "aks" {
  source              = "../modules/aks"
  name                = local.prefix
  environment         = var.environment
  kubernetes_version  = var.kubernetes_version
  resource_group_name = module.iam.resource_group_name
  location            = module.iam.location
  private_subnet      = module.vnet.private_subnets
  user_assigned_id    = module.iam.user_id

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}
```

## Vnet Module Example usage
Usage: The following module call will create Azure virtual network(Vnet) and Subnet resources. Resources will be configured using the following input variables on this module.

```
# Azure Virtuval network module
module "vnet" {
  source                    = "../modules/vnet"
  name                      = local.prefix
  environment               = var.environment
  resource_group_name       = module.iam.resource_group_name
  location                  = module.iam.location
  public_subnet_prefixes    = var.public_subnet_prefixes
  private_subnet_prefixes   = var.private_subnet_prefixes
  private_service_endpoints = var.private_service_endpoints
  policy_id                 = module.storage.policy_id

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}
```

## IAM module example usage
Usage: The following module call will create Identity resources. Resources will be configured using the following input variables on this modules.

```
# Azure Identities module
module "iam" {
  source      = "../modules/iam"
  name        = local.prefix
  environment = var.environment
  location    = var.region
  tags        = local.tags
}
```

## storage module example usage
Usage: The following module call will create Azure cloud Storage Account. Resources will be configured using following input variables on this module.
```
# Azure Storage Account module
module "storage" {
  source              = "../modules/storage"
  name                = local.prefix
  environment         = var.environment
  resource_group_name = module.iam.resource_group_name
  location            = module.iam.location

  tags = merge(local.tags, { "resource_group" = module.iam.resource_group_name })
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.49.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.49.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ../modules/aks |  |
| <a name="module_iam"></a> [iam](#module\_iam) | ../modules/iam |  |
| <a name="module_storage"></a> [storage](#module\_storage) | ../modules/storage |  |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ../modules/vnet |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.49.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | version of the kubernetes cluster | `string` | `"1.19.9"` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | Maximum Node Count | `number` | `5` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | Minimum Node Count | `number` | `3` | no |
| <a name="input_name"></a> [name](#input\_name) | AKS name in Azure | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of AKS worker nodes | `number` | `5` | no |
| <a name="input_private_service_endpoints"></a> [private\_service\_endpoints](#input\_private\_service\_endpoints) | service endpoints to attach Private Subnets. | `list(string)` | <pre>[<br>  "Microsoft.Storage"<br>]</pre> | no |
| <a name="input_private_subnet_prefixes"></a> [private\_subnet\_prefixes](#input\_private\_subnet\_prefixes) | value | `list(string)` | <pre>[<br>  "10.1.1.0/24"<br>]</pre> | no |
| <a name="input_public_service_endpoints"></a> [public\_service\_endpoints](#input\_public\_service\_endpoints) | service endpoints to attche public Subnets. | `list(string)` | `[]` | no |
| <a name="input_public_subnet_prefixes"></a> [public\_subnet\_prefixes](#input\_public\_subnet\_prefixes) | value | `list(string)` | <pre>[<br>  "10.1.0.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | Azure location where all the resources being created. | `string` | n/a | yes |
| <a name="input_system_node_count"></a> [system\_node\_count](#input\_system\_node\_count) | Number of AKS worker nodes | `number` | `3` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size\_count) | Specifies the size of the virtual machine. | `string` | `Standard_E8_v4` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_fqdn"></a> [aks\_fqdn](#output\_aks\_fqdn) | Azure kuberenetes service fqdn. |
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | Azure kuberenetes service id. |
| <a name="output_connect_cluster"></a> [connect\_cluster](#output\_connect\_cluster) | Connection string to be used to configure kubectl. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The name of the resource group in which the resources will be created. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | Azure Storage account id. |
