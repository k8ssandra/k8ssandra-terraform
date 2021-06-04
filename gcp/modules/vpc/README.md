# Google Compute Network
This is a Dynamic module in Terraform to create compute Network(VPC). This module will be called from the ./env/dev.tf file. 

* main.tf : contains all the resources, which will be created with `terraform apply` command.
* variables.tf : contains all the variables required to create the resources.
* outputs.tf : print output attributes of the resources.

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
| [google_compute_firewall.http_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.https_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.rdp_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.ssh_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.vpc_compute_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.compute_router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_cidr_subnetwork_spacing"></a> [cidr\_subnetwork\_spacing](#input\_cidr\_subnetwork\_spacing) | How many subnetwork-mask sized spaces to leave between each subnetwork type. | `number` | `0` | no |
| <a name="input_cidr_subnetwork_width_delta"></a> [cidr\_subnetwork\_width\_delta](#input\_cidr\_subnetwork\_width\_delta) | The difference between your network and subnetwork netmask; an /16 network and a /20 subnetwork would be 4. | `number` | `4` | no |
| <a name="input_cloud_nat_logging_filter"></a> [cloud\_nat\_logging\_filter](#input\_cloud\_nat\_logging\_filter) | What filtering should be applied to logs for this NAT. Valid values are: 'ERRORS\_ONLY', 'TRANSLATIONS\_ONLY', 'ALL'. Defaults to 'ERRORS\_ONLY'. | `string` | `"ERRORS_ONLY"` | no |
| <a name="input_enable_cloud_nat"></a> [enable\_cloud\_nat](#input\_enable\_cloud\_nat) | Whether to enable Cloud NAT. This can be used to allow private cluster nodes to accesss the internet. Defaults to 'true' | `bool` | `true` | no |
| <a name="input_enable_cloud_nat_logging"></a> [enable\_cloud\_nat\_logging](#input\_enable\_cloud\_nat\_logging) | Whether the NAT should export logs. Defaults to 'true'. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project in which to hold the components | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which to create the VPC network | `string` | n/a | yes |
| <a name="input_secondary_cidr_block"></a> [secondary\_cidr\_block](#input\_secondary\_cidr\_block) | The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27. | `string` | `"10.1.0.0/16"` | no |
| <a name="input_secondary_cidr_subnetwork_spacing"></a> [secondary\_cidr\_subnetwork\_spacing](#input\_secondary\_cidr\_subnetwork\_spacing) | How many subnetwork-mask sized spaces to leave between each subnetwork type's secondary ranges. | `number` | `0` | no |
| <a name="input_secondary_cidr_subnetwork_width_delta"></a> [secondary\_cidr\_subnetwork\_width\_delta](#input\_secondary\_cidr\_subnetwork\_width\_delta) | The difference between your network and subnetwork's secondary range netmask; an /16 network and a /20 subnetwork would be 4. | `number` | `4` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_selflink"></a> [network\_selflink](#output\_network\_selflink) | variable for the vpc network selflink |
| <a name="output_subnetwork_selflink"></a> [subnetwork\_selflink](#output\_subnetwork\_selflink) | variable for the subnetwork selflink |
