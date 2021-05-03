# Terraform AWS IAM module
This is a Dynamic module in Terraform to create IAM resources. This module will be called from ../env/dev.tf modules file. This module creates roles, policies.

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
| [aws_iam_instance_profile.iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.worker_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.service_linked_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.CNI_policy_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.EC2ContainerRegistryReadOnly_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.EKSVPCResourceController_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.WorkerNode_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.clusterPolicy_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.servicePolicy_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastrure being built. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to give the new Kubernetes cluster resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The aws regionwhere terraform builds resources. | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to attach all the resources create in this project. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assume_role_arn"></a> [assume\_role\_arn](#output\_assume\_role\_arn) | AWS Iam assume role arn. |
| <a name="output_iam_instance_profile"></a> [iam\_instance\_profile](#output\_iam\_instance\_profile) | AWS Iam instace profile id. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | Output attibutes of the iam resources. AWS Iam role arn. |
| <a name="output_worker_role_arn"></a> [worker\_role\_arn](#output\_worker\_role\_arn) | AWS Iam worker role arn. |
