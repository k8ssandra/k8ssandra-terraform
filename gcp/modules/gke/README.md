# GKE Clusters Module
Dynamic terraform GKEe cluster module code. this module will be called from ../env/dev.tf modules file, by using this module reusable module we will be able to create gke cluster and node pools.

main.tf contains all the resources, which will be created while terraform apply, variables.tf file containes all the variables required to create the resources and outputs.tf files for output the attributes of the resources.

by using this module following resources will be created
    -   GKE cluster
    -   Cluster node pool
