## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ../modules/eks |  |
| <a name="module_iam"></a> [iam](#module\_iam) | ../modules/iam |  |
| <a name="module_s3"></a> [s3](#module\_s3) | ../modules/s3 |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../modules/vpc |  |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastrure being built. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to be used in the k8ssandra. | `string` | `"r5d.2xlarge"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to give the new Kubernetes cluster resources. | `string` | n/a | yes |
| <a name="input_private_cidr_block"></a> [private\_cidr\_block](#input\_private\_cidr\_block) | List of private subnet cidr blocks | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_public_cidr_block"></a> [public\_cidr\_block](#input\_public\_cidr\_block) | List of public subnet cidr blocks | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24",<br>  "10.0.103.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The aws region in which resources will be defined. | `string` | `"us-east-1"` | no |
| <a name="input_resource_owner"></a> [resource\_owner](#input\_resource\_owner) | The name of the Project Owner | `string` | `"Datastax"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Bucket Name (aka ID) |
| <a name="output_cluster_Endpoint"></a> [cluster\_Endpoint](#output\_cluster\_Endpoint) | The endpoint for your EKS Kubernetes API |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the EKS cluster |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | Version of the EKS cluster |
