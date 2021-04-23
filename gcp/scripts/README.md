# Scripts to create and destroy the resources

## What's in this folder

* [apply.sh](./apply.sh): By using this script we can apply changes to the Terraform resources in GCP.
* [common.sh](./common.sh): By using this script we can validate the required packages and variables on your system. This script will be called in `apply.sh`, `init.sh`, `validate.sh`, `destroy.sh`, `plan.sh`.  
* [delete_bucket.py](./delete_bucket.py): By using this script we can delete the GCP bucket created for terraform state files.
* [destroy.sh](./destroy.sh): By using this script we can destroy all the resource Created Terraform.  
* [enable.sh](./enable.sh): By using this script we can enable the google api's
* [init.sh](./init.sh): By using this script we can initialize the modules, Terraform workspace, environment and create terraform statefile bucket.
* [make_bucket.py](./make_bucket.py): This script is used by [init.sh](./init.sh) to create terraform Statefiles bucket in GCP.  
* [plan.sh](./plan.sh): By using this script we plan the resources by running `terraform plan` command. 
