# GKE Clusters Terraform Module
This is a Dynamic module in terraform to create GKE cluster. This module will be called from ../env/dev.tf modules file, by using this reusable module we will be able to create GKE cluster and Cluster Node Pool.

* main.tf : contains all the resources which will be created with `terraform apply` command.
* variables.tf : contains all the variables required to create the resources.
* outputs.tf : prints output attributes of the resources.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.container_cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.container_node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | (Beta) Whether the master's internal IP address is used as the cluster endpoint | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | (Beta) Whether nodes have internal IP addresses only | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | n/a | `number` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Type of machines which are used by cluster node pool | `string` | `"e2-highmem-8"` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation (size must be /28) to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network. | `string` | `"10.0.0.0/28"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_network_link"></a> [network\_link](#input\_network\_link) | network link variable from vpc module outputs | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID where all resources will be launched. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location of the GKE cluster. | `string` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters | `string` | `""` | no |
| <a name="input_subnetwork_link"></a> [subnetwork\_link](#input\_subnetwork\_link) | subnetwork link variable from vpc module outputs | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | GKE cluster name |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | End point of the google container cluster |
| <a name="output_master_version"></a> [master\_version](#output\_master\_version) | Master version of Kubernetes cluster |
