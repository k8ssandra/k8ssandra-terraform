# Google Identity Access Management module
This is a Dynamic module in Terraform to create IAM resources. This module will be called from ../env/dev.tf modules file. This module creates a Services Account and IAM memebers and roles.

* main.tf : contains all the resources, which will be created with `terraform apply` command.
* variables.tf : contains all the variables required to create the resources.
* outputs.tf : print output attributes of the resources.


## Google cloud resources created
* Service Account will be created 
* IAM member with roles attached
* Custom IAM member with roles attached
* Project Services.


## Providers
|       NAME        |   Version  | 
|-------------------|------------|
| terraform version |   0.14     |
| gcp provider      |   ~>3.0    |

## Inputs

|       Name        |   Description  |  Type  |  Required    |
|-------------------|----------------|--------|:------------:|
| name |  name of the cluster and prefix of the related resources names | `string` | yes |
| project_id |  Id of the project which holds the components | `string` | yes |
| region | the region to create the vpc network | `string` | yes |
| service_account_custom_iam_roles | service account custom iam roles | `list` | no |
| service_account_iam_roles | service account iam roles | `list` | no |
| project_services | The GCP APIs that should be enabled in this project. | `list` | no |


## Outputs

|    Name     |    description   | 
|-------------|:----------------:|
| service_account | service account email |
