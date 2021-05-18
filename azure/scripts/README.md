# Scripts to create and destroy the resources

## What's in this folder

* [apply.sh](./apply.sh): By using this script we can apply changes to the Terraform resources in Azure.
* [common.sh](./common.sh): By using this script we can validate the required packages and variables on your system. This script will be called in `apply.sh`, `init.sh`, `validate.sh`, `destroy.sh`, `plan.sh`.  
* [delete_storage_account.py](./delete_storage_account.py): By using this script we can delete the storage account created for terraform state files.
* [destroy.sh](./destroy.sh): By using this script we can destroy all the resource created by Terraform.  
* [init.sh](./init.sh): By using this script we can initialize the modules, Terraform workspace, environment and create terraform State files bucket.
* [create_storage_account.py](./create_storage_account.py): This script is used by [init.sh](./init.sh) to create terraform State files Storage Account in Azure.  
* [plan.sh](./plan.sh): By using this script we plan the resources by running `terraform plan` command. 
