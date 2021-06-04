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
  source             = "../modules/gke"
  environment        = var.environment
  name               = local.prefix
  region             = var.region
  project_id         = var.project_id
  initial_node_count = var.initial_node_count
  machine_type       = var.machine_type
  network_link       = module.vpc.network_selflink
  subnetwork_link    = module.vpc.subnetwork_selflink
  service_account    = module.iam.service_account
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
Usage: The following module call will create google compute network(VPC) and Google Compute Subnet resources. Resources will be configured using the following input variables on this module. 

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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcs"></a> [gcs](#module\_gcs) | ../modules/gcs |  |
| <a name="module_gke"></a> [gke](#module\_gke) | ../modules/gke |  |
| <a name="module_iam"></a> [iam](#module\_iam) | ../modules/iam |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../modules/vpc |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure being built. | `any` | n/a | yes |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | n/a | `number` | `1` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | The namespace to use for the deployment and workload identity binding | `string` | `"default"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Type of machines which are used by cluster node pool | `string` | `"e2-highmem-8"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | `"k8ssandra"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project in which the components are created. | `string` | `"k8ssandra-testing"` | no |
| <a name="input_project_services"></a> [project\_services](#input\_project\_services) | The GCP APIs that should be enabled in this project. | `list(string)` | <pre>[<br>  "cloudresourcemanager.googleapis.com",<br>  "servicenetworking.googleapis.com",<br>  "container.googleapis.com",<br>  "compute.googleapis.com",<br>  "iam.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "sqladmin.googleapis.com",<br>  "securetoken.googleapis.com"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which to create the VPC network | `string` | `"us-central1"` | no |
| <a name="input_service_account_custom_iam_roles"></a> [service\_account\_custom\_iam\_roles](#input\_service\_account\_custom\_iam\_roles) | List of arbitrary additional IAM roles to attach to the service account on<br>the GKE nodes. | `list(string)` | `[]` | no |
| <a name="input_service_account_iam_roles"></a> [service\_account\_iam\_roles](#input\_service\_account\_iam\_roles) | List of the default IAM roles to attach to the service account on the GKE Nodes. | `list(string)` | <pre>[<br>  "roles/logging.logWriter",<br>  "roles/monitoring.metricWriter",<br>  "roles/monitoring.viewer",<br>  "roles/stackdriver.resourceMetadata.writer"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone in which to create the Kubernetes cluster. Must match the region | `string` | `"us-central-1a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the GCS bucket. |
| <a name="output_connect_cluster"></a> [connect\_cluster](#output\_connect\_cluster) | Configuring GKE cluster access for kubectl |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Endpoint for the GKE cluster |
| <a name="output_master_version"></a> [master\_version](#output\_master\_version) | Master version of GKE cluster |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The E-mail id of the service account. |
| <a name="output_service_account_key"></a> [service\_account\_key](#output\_service\_account\_key) | The service Account Key to configure Medusa backups to use GCS bucket |
