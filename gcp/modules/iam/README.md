# Google Identity Access Management
Dynamic Terraform IAM module code. This module will be called from ../env/dev.tf modules file. This module creates a services account and iam memebers and roles.

main.tf contains all the resources, which will be created while terraform apply, variables.tf file containes all the variables required to create the resources and outputs.tf files for output the attributes of the resources.


## Google cloud resources
* service account will be created 
* iam member with roles attached
* custom iam member with roles attached


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


## Outputs

|    Name     |    description   | 
|-------------|:----------------:|
| service_account | service account email |
