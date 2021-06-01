# Terraform google cloud storage module 
This is a Dynamic modules in Terraform to create a GCS bucket and assign basic permissions to the users.

* main.tf : contains all the resources which will be created with `terraform apply` command. 
* variables.tf : contains all variables required to create the resources.
* outputs.tf : contains output attributes of the resources. 

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.storage_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.storage_bucket_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_policy_only"></a> [bucket\_policy\_only](#input\_bucket\_policy\_only) | Enables Bucket Policy Only access to a bucket. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project to create the bucket in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where terraform builds resources. | `string` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | Role of the google storage bucket iam member | `string` | `"roles/storage.admin"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | service account email address | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Storage class for the gcs bucket | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | name of the google cloud storage bucket |
