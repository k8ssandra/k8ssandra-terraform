# Terraform google cloud storage module 
This is a Dynamic modules in Terraform to create a GCS bucket and assign basic persmissions to the users.


* main.tf : contains all the resources which will be created with `terraform apply` command. 
* variables.tf : contains all variables required to create the resources.
* outputs.tf : contains output attributes of the resources. 

## google cloud resources created
* google cloud storage bucket
* google storage bucket iam member

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
| storage_class | Storage class for the gcs bucket | `string` | no |
| bucket_policy_only | Enables Bucket Policy Only access to a bucket | `boolean` | no | 
| role | Role of the google storage bucket iam member | `string` | no |
| service_account | service account email address | `string` | yes |

## Output

|    Name     |    description   | 
|-------------|:----------------:|
| bucket_name | name of the google cloud storage bucket |
