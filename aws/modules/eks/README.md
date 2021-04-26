# Terraform AWS EKS module

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
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.eks_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of the EKS cluster. | `string` | `"1.19"` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired capacity for the autoscaling Group. | `string` | `"3"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastrure being built. | `string` | n/a | yes |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | Instance profile name to attach aws lunch configuration. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to be used in the k8ssandra. | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of the instances in autoscaling group | `string` | `"5"` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of the instances in autoscaling group | `string` | `"3"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to give the new Kubernetes cluster resources. | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets to create the resources. | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The aws region in kwhich resources will be defined. | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Iam role arn to attach the EKS cluster. | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security group id to configure eks cluster. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet id to attach the eks cluster. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to attach all the resources create in this project. | `map(string)` | n/a | yes |
| <a name="input_worker_role_arn"></a> [worker\_role\_arn](#input\_worker\_role\_arn) | Iam worker role arn to attach the EKS cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Output attributes  of the eks cluster. |