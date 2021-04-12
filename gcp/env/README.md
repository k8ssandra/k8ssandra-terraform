# Terraform Modules Folder

All the module calls made from this folder from dev.tf file. 

* This folder contains following files
  * dev.tf (modules file )
  * backend.tf ( contains backend configuration of the terraform, which contains terraform state files).
  * outputs.tf ( output's of the resource attributes after terraform apply)
  * version.tf ( contains terraform version and cloud provider version)
  * variables.tf (all the variable which required by the terraform modules.)

## What is a module?
A [Terraform Module](https://www.terraform.io/docs/language/modules/develop/index.html) is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such as a database or server cluster. Each Module is written using a combination of Terraform and scripts (mostly bash) and include automated tests, documentation, and examples.

* Every module has:
  * Input variables: to accept values from the calling module.
  * Output values: to return results to the calling module, which it can then use to populate arguments elsewhere.
  * Resources: to define one or more infrastructure objects that the module will manage.
  * Source: A source can be any local folder path or remote module located in source control systems like git.

## GKE cluster example module
Usage: The following module call will create GKE cluster and cluster node pool resources. Resources will be configured by using the following input variables on this module. 

```
# Module used for creating a google kubernetes cluster.
module "gke" {
  source          = "../modules/gke"
  name            = local.prefix
  environment     = var.environment
  region          = var.region
  project         = var.project_id
  network_link    = module.vpc.network_selflink
  subnetwork_link = module.vpc.subnetwork_selflink
  service_account = module.iam.service_account
}

```   
## IAM example module
Usage: The following module call will create IAM resources. Resources will be configured using the following input variables on this modules.   

```
# Module used for create service account and roles
module "iam" {
  source                           = "../modules/iam"
  name                             = local.prefix
  region                           = var.region
  project_id                       = var.project_id
  service_account_custom_iam_roles = var.service_account_custom_iam_roles
  service_account_iam_roles        = var.service_account_iam_roles
}

```

## vpc example module
Usage: The following module call will create google compute network(VPC) and Gooogle Compute Subnet resources. Resources will be configured using the following input variables on this module. 

```
# Module used for creating a google compute network.
module "vpc" {
  source           = "../modules/vpc"
  name             = local.prefix
  environment     = var.environment
  region           = var.region
  project_id       = var.project_id
  project_services = var.project_services
}

```

## gcs example module
Usage: The following module call will create google cloud storage bucket. Resources will be configured using following input variables on this module.

```
# Module used for create google cloud storage bucket
module "gcs" {
  source          = "../modules/gcs"
  name            = format("%s-storage-bucket", local.prefix)
  region          = var.region
  environment     = var.environment
  project_id      = var.project_id
  service_account = module.iam.service_account
}

```
## Providers

|       NAME        |   Version  | 
|-------------------|------------|
| terraform version |   0.14     |
| gcp provider      |   ~>3.0    |

## Inputs

|       Name        |   Description  |  Type  |  Required    |
|-------------------|----------------|--------|:------------:|
| name |  Name of the cluster and prefix of the related resources names | `string` | yes |
| environment | Environment of the infrastructure being buit | `string` | yes | 
| project_id |  Id of the project which holds the components | `string` | yes |
| region | the region to create the vpc network | `string` | yes |
| k8s_namespace | The namespace to use for the deployment and workload identity binding | `string` | no |
| zone | The zone in which to create the Kubernetes cluster. Must match the region | `string` | yes |
| service_account_iam_roles | iam roles for the service account | `list` | yes |
| service_account_custom_iam_roles | List of arbitrary additional IAM roles to attach to the service account on
  the GKE nodes. | `list` | no |
| project_services | The GCP APIs that should be enabled in this project. | `list` | yes |

## Outputs

|    Name     |    description   | 
|-------------|:----------------:|
|   endpoint  | google container cluster endpoint |
| master_version| google container cluster master version |
| bucket_name | google storage bucket name |