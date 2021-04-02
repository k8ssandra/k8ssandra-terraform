# Google Compute Network
Dynamic terraform vpc module code. this module will be called from the ./env/dev.tf file. 

main.tf contains all the resources, which will be created while terraform apply, variables.tf file containes all the variables required to create the resources and outputs.tf files for output the attributes of the resources.

This module creates the following google cloud resources
    -   google compute network(VPC)
    -   public subnet
    -   private subnet
    -   router
    -   compute router nat
