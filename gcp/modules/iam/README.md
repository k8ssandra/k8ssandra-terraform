# Google Identity Access Management
Dynamic Terraform IAM module code. this module will be called from ../env/dev.tf modules file. This module creates a services account and iam memebers and roles.

main.tf contains all the resources, which will be created while terraform apply, variables.tf file containes all the variables required to create the resources and outputs.tf files for output the attributes of the resources.

-This module will create the Following google cloud resources
    -   service account will be created 
    -   iam member with roles attached
    -   custom iam member with roles attached
