# K8ssandra AWS Terraform Module

## What is Elastic Kubernetes Service(EKS)?
[Amazon Elastic Kubernetes Service](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html) is a managed kubernetes service on AWS, it gives user flexibility to run and scale kubernetes applications in the AWS cloud.


## Terraform Resources created
* EKS cluster
* EKS node group
* IAM roles
* IAM role policy
* IAM role policy attachment
* S3 Bucket
* S3 Bucket public access block
* Virtual Private Cloud
* Subnets
* Security Groups
* Security Group rule
* NAT Gateway
* Internet Gateway
* elastic IP
* Route Table
* Route Table association

## Project directory Structure
<pre>
aws/
 ├──modules/
 |  ├──<a href="modules/s3/README.md">s3</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md 
 |  ├──<a href="modules/vpc/README.md">vpc</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md 
 |  ├──<a href="modules/iam/README.md">iam</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md
 |  ├──<a href="modules/eks/README.md">eks</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md
 └──README.md
 └──gitignore
 |
 ├──<a href="env/README.md">env</a>
    ├── dev.tf
      ../modules/vpc
      ../modules/iam
      ../modules/gke
      ../modules/gcs
    ├── version.tf 
    └── backend.tf 
    └── variables.tf 
    └── outputs.tf
    └── README.md
</pre>

## Prerequisites

|       NAME          |   Version  | 
|---------------------|------------|
| Terraform version   |   0.14     |
| aws provider        |   ~>3.0    |
| Helm version        |   v3.5.3   |
|   AWS CLI           |  version2  |
|   boto 3            |            |   
|  kubectl            |  1.17.17   |
|  python             |    3       |
|aws-iam-authenticator|   0.5.2    |


### Tools

* Access to an existing AWS cloud as a owner or a developer.
* Bash and common command line tools (Make, etc.)
* [Terraform v0.14.0+](https://www.terraform.io/downloads.html)
* [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html))
* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) that matches the latest generally-available GKE cluster version.

#### Install Terraform

Terraform is used to automate the manipulation of cloud infrastructure. Its [Terraform installation instructions](https://www.terraform.io/intro/getting-started/install.html) are also available online.

#### Install aws-iam-authenticator

Amazon EKS uses IAM to provide authentication to your Kubernetes cluster through the AWS IAM authenticator for Kubernetes. Follow the instructions to install [aws-iam-authenticator installation instructions](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

#### Install kubectl
Kubernetes uses a command line utility called kubectl for communicating with the cluster API server. The kubectl binary is available in many operating system package managers, and this option is often much easier than a manual download and install process. Follow the instructions to install [kubectl installation instructions](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html).

### Configure AWS CLI
Run `aws configure` command to configure your AWS cli, This Terraform module AWS CLI v2, if you have older versions of AWS CLI use the following instructions to uninstall older versions.

* [uninstall AWS cli v1](https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html)
* [Install AWS cli v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

```console
AWS configure
```
Enter `access key`, `secret access key` default `region`.

## Test this project locally

Export the following terraform environment variables(TFVARS) for terraform to create the resources. 
```console

export TF_VAR_environment=<ENVIRONMENT_REPLACEME>
ex:- export TF_VAR_environment=dev

export TF_VAR_name=<CLUSTERNAME_REPLACEME>
ex:- export TF_VAR_name=k8ssandra

export TF_VAR_region=<REGION_REPLACEME>
ex:- export TF_VAR_region=us-east-1

```

Important: Initialize the terraform modules delete the backend file for local testing.

```console
cd env/
terraform init
````

After the terraform initialization is successful, create your workspace and by using the following command

```console
terraform workspace new <WORKSPACENAME_REPLACEME>
```

or select the workspace if there are any existing workspaces

```console
terraform workspace select <WORKSPACENAME_REPLACEME>
```

run the following commands

```console
terraform plan
terraform apply
```
