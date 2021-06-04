# Scripts to create and destroy the resources

## What's in this folder

* [apply.sh](./apply.sh): By using this script we can apply changes to the Terraform resources in AWS.
* [common.sh](./common.sh): By using this script we can validate the required packages and variables on your system. This script will be called in `apply.sh`, `init.sh`, `validate.sh`, `destroy.sh`, `plan.sh`.  
* [destroy.sh](./destroy.sh): By using this script we can destroy all the resource Created Terraform.  
* [init.sh](./init.sh): By using this script we can initialize the modules, Terraform workspace, environment and create terraform State file bucket.
* [make_bucket.py](./make_bucket.py): This script will be used to create terraform state files bucket in AWS.
* [plan.sh](./plan.sh): By using this script we plan the resources by running `terraform plan` command. 
* [validate.sh](./validate.sh): By using this script we can validate the Terraform code.


**Only use this script to delete state files bucket, This bucket might also contains other environment State files.** 
If you delete this bucket terraform will lose track of your environment resources. 
[delete_bucket.py](./delete_bucket.py): By using this script we can delete the bucket created in AWS S3.
