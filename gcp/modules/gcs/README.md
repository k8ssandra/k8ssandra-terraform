# Terraform google cloud storage module 
Dynamic terraform GCS module code. by using this module to create google cloud storage bucket and assign basic persmissions to the users. 


main.tf contains all the resources which will be created while terraform apply, variables.tf file containes all the variables required to create the resources and outputs.tf files for output the attributes of the resources.


## google cloud resources
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
