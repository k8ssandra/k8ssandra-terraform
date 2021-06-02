# Terraform AWS VPC module
This is a Dynamic module in Terraform to create Virtual Private Cloud (VPC). This module will be called from the [`../env/dev.tf`](../env/dev.tf) file. 

* main.tf : contains all the resources, which will be created with `terraform apply` command.
* variables.tf : contains all the variables required to create the resources.
* outputs.tf : print output attributes of the resources.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.mod_nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.internet_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_nat_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.worker_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cluster_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.http_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.self_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.workstation_http_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.availability_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_api_cidr"></a> [cluster\_api\_cidr](#input\_cluster\_api\_cidr) | Allow workstation to communicate with the cluster API Server | `string` | `"10.2.0.0/32"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure is being built. | `string` | n/a | yes |
| <a name="input_multi_az_nat_gateway"></a> [multi\_az\_nat\_gateway](#input\_multi\_az\_nat\_gateway) | place a NAT gateway in each AZ | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_private_cidr_block"></a> [private\_cidr\_block](#input\_private\_cidr\_block) | List of private subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_public_cidr_block"></a> [public\_cidr\_block](#input\_public\_cidr\_block) | List of public subnet CIDr blocks | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where terraform builds resources. | `string` | n/a | yes |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | use a single NAT gateway to serve outbound traffic for all AZs | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to attach all the resources create in this project. | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | Virtual Private Cloud CIDR block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_enable_classiclink"></a> [vpc\_enable\_classiclink](#input\_vpc\_enable\_classiclink) | n/a | `bool` | `"false"` | no |
| <a name="input_vpc_enable_dns_hostnames"></a> [vpc\_enable\_dns\_hostnames](#input\_vpc\_enable\_dns\_hostnames) | n/a | `bool` | `"true"` | no |
| <a name="input_vpc_enable_dns_support"></a> [vpc\_enable\_dns\_support](#input\_vpc\_enable\_dns\_support) | n/a | `bool` | `"true"` | no |
| <a name="input_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#input\_vpc\_instance\_tenancy) | Optional Variables # Exposed VPC Settings. | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_eip_nat_ips"></a> [aws\_eip\_nat\_ips](#output\_aws\_eip\_nat\_ips) | Output attribute of the elastic ip. |
| <a name="output_aws_nat_gateway_count"></a> [aws\_nat\_gateway\_count](#output\_aws\_nat\_gateway\_count) | Output attributes of the NAT gateway --------------------------------------- |
| <a name="output_aws_nat_gateway_ids"></a> [aws\_nat\_gateway\_ids](#output\_aws\_nat\_gateway\_ids) | n/a |
| <a name="output_aws_route_table_private_ids"></a> [aws\_route\_table\_private\_ids](#output\_aws\_route\_table\_private\_ids) | n/a |
| <a name="output_aws_route_table_public_ids"></a> [aws\_route\_table\_public\_ids](#output\_aws\_route\_table\_public\_ids) | Output attributes of the route table id's. --------------------------------------------- |
| <a name="output_aws_subnet_private_ids"></a> [aws\_subnet\_private\_ids](#output\_aws\_subnet\_private\_ids) | n/a |
| <a name="output_aws_subnet_public_ids"></a> [aws\_subnet\_public\_ids](#output\_aws\_subnet\_public\_ids) | Output attribute of the public and private subnet's ---------------------------------------------------- |
| <a name="output_aws_vpc_cidr"></a> [aws\_vpc\_cidr](#output\_aws\_vpc\_cidr) | output attribute of the VPC CIDR block. |
| <a name="output_aws_vpc_id"></a> [aws\_vpc\_id](#output\_aws\_vpc\_id) | Output attributes for the VPC module Output attribute id of the VPC |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Output attributes of the Security group. ----------------------------------------- |
| <a name="output_worker_security_group_id"></a> [worker\_security\_group\_id](#output\_worker\_security\_group\_id) | n/a |
