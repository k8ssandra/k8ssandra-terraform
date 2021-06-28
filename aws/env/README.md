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

## EKS cluster example module
Usage: The following module call will create EKS cluster and cluster node pool resources. Resources will be configured by using the following input variables on this module. 

```
# Create Elastic Kubernetes Service
module "eks" {
  source                = "../modules/eks"
  name                  = local.name_prefix
  region                = var.region
  environment           = var.environment
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
  instance_type         = var.instance_type
  role_arn              = module.iam.role_arn
  worker_role_arn       = module.iam.worker_role_arn
  subnet_ids            = module.vpc.aws_subnet_private_ids
  security_group_id     = module.vpc.security_group_id
  public_subnets        = module.vpc.aws_subnet_public_ids
  instance_profile_name = module.iam.iam_instance_profile
  tags                  = local.tags
}
```
## IAM example module
Usage: The following module call will create IAM resources. Resources will be configured using the following input variables on this modules.   

```
# Create Identity Access Management
module "iam" {
  source      = "../modules/iam"
  name        = local.name_prefix
  region      = var.region
  environment = var.environment
  tags        = local.tags
}

```

## vpc example module
Usage: The following module call will create AWS virtual private network(VPC), subnets, firewall rules, security groups, NAT Gateway's, Internet Gateway, Elastic IP's, route tables, route table associations.

```
# Create Virtual Private Cloud
module "vpc" {
  source             = "../modules/vpc"
  name               = local.name_prefix
  environment        = var.environment
  region             = var.region
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  tags               = local.tags
}
```

## s3 example module
Usage: The following module call will create Amazon s3 bucket. Resources will be configured using following input variables on this module.

```
# Create S3 bucket
module "s3" {
  source      = "../modules/s3"
  name        = local.name_prefix
  environment = var.environment
  tags        = local.tags
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ../modules/eks |  |
| <a name="module_iam"></a> [iam](#module\_iam) | ../modules/iam |  |
| <a name="module_s3"></a> [s3](#module\_s3) | ../modules/s3 |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../modules/vpc |  |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Desired capacity for the auto scaling Group. | `number` | `"3"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment where infrastructure is being built. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to be used for the Kubernetes cluster. | `string` | `"r5d.2xlarge"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of the instances in autoscaling group | `number` | `"5"` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of the instances in autoscaling group | `nunmber` | `"3"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name is the prefix to use for resources that needs to be created. | `string` | n/a | yes |
| <a name="input_private_cidr_block"></a> [private\_cidr\_block](#input\_private\_cidr\_block) | List of private subnet cidr blocks | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_public_cidr_block"></a> [public\_cidr\_block](#input\_public\_cidr\_block) | List of public subnet cidr blocks | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24",<br>  "10.0.103.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where terraform builds resources. | `string` | `"us-east-1"` | no |
| <a name="input_resource_owner"></a> [resource\_owner](#input\_resource\_owner) | The name of the Project Owner | `string` | `"Datastax"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Bucket Name (aka ID) |
| <a name="output_cluster_Endpoint"></a> [cluster\_Endpoint](#output\_cluster\_Endpoint) | The endpoint for your EKS Kubernetes API |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the EKS cluster |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | Version of the EKS cluster |
