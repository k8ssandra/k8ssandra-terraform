# Google Identity Access Management module
This is a Dynamic module in Terraform to create IAM resources. This module will be called from ../env/dev.tf modules file. This module creates a Services Account and IAM memebers and roles.

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
| [google_project_iam_member.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_account_custom](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.project_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.service_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project in which to hold the components | `string` | n/a | yes |
| <a name="input_project_services"></a> [project\_services](#input\_project\_services) | n/a | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which to create the VPC network | `string` | n/a | yes |
| <a name="input_service_account_custom_iam_roles"></a> [service\_account\_custom\_iam\_roles](#input\_service\_account\_custom\_iam\_roles) | service account custom iam roles | `list(string)` | `[]` | no |
| <a name="input_service_account_iam_roles"></a> [service\_account\_iam\_roles](#input\_service\_account\_iam\_roles) | service account custom iam roles | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | Service Account Email-id |
| <a name="output_service_account_key"></a> [service\_account\_key](#output\_service\_account\_key) | The service Account Key to configure Medusa backups to use GCS bucket |
