All the module calls made from this folder from dev.tf file this folder contains 

    dev.tf (modules file )
    backend.tf ( contains backend configuration of the terraform, which contains terraform state files).
    outputs.tf ( output's of the resource attributes after terraform apply)
    version.tf ( contains terraform version and cloud provider version)
    variables.tf (all the variable which required by the terraform modules.)

## Gke cluster example module
```
# Module call to create gke cluster
module "gke" {
  source          = "../modules/gke"
  name            = local.prefix
  region          = var.region
  project         = var.project_id
  network_link    = module.vpc.network_selflink
  subnetwork_link = module.vpc.subnetwork_selflink
  service_account = module.iam.service_account
}

```

## Iam example module
```
# Module call to create service account and roles
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
```
# Module call for creating google compute network
module "vpc" {
  source           = "../modules/vpc"
  name             = local.prefix
  region           = var.region
  project_id       = var.project_id
  project_services = var.project_services
}

```

## gcs example module
```
# Module call to create google cloud storage bucket
module "gcs" {
  source          = "../modules/gcs"
  name            = format("%s-storage-bucket", local.prefix)
  region          = var.region
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
