# K8ssandra Azure Terraform Module

## What is Azure Kubernetes Service(AKS)?
[Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes) Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance. Since Kubernetes masters are managed by Azure, you only manage and maintain the agent nodes. Thus, AKS is free; you only pay for the agent nodes within your clusters, not for the masters.

## Terraform Resources created
* AKS cluster
* AKS default node pool
* Managed Identity
* Storage Account
* Storage container
* Virtual Network(Vnet)
* Subnets
* Network Security Group
* NAT Gateway
* Public IP
* Route Table
* Route Table association

## Project directory Structure
<pre>
Azure/
 ├──modules/
 |  ├──<a href="modules/storage/README.md">storage</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md 
 |  ├──<a href="modules/vnet/README.md">vnet</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md 
 |  ├──<a href="modules/iam/README.md">iam</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md
 |  ├──<a href="modules/aks/README.md">aks</a>
 |     ├── main.tf 
 |     └── variables.tf 
 |     └── outputs.tf 
 |     └── README.md
 |
 ├──<a href="env/README.md">env</a>
 |  ├── dev.tf
 |  ├── version.tf 
 |  └── backend.tf 
 |  └── variables.tf 
 |  └── outputs.tf
 |  └── README.md
 └──README.md
</pre>

## Prerequisites

|       NAME          |   Version  | 
|---------------------|------------|
| Terraform version   |   0.14     |
| Azurerm provider    |   ~>2.49.0 |
| Helm version        |   v3.5.3   |
|   AZ CLI            |  ~>2.22.1  |   
|  kubectl            |  ~>1.17.17 |
|  python             |    3       |

### Backend
  * Terraform uses persistent state data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.
  * Terraform backend configuration: 
  [Configuring your backend in Azure](https://www.terraform.io/docs/language/settings/backends/azurerm.html)
  * Terraform state
  [How Terraform state works](https://www.terraform.io/docs/language/state/index.html)

Sample template to configure your backend in Azure Storage Account:
```
# example Backend configuration.
terraform {
  backend "azurerm" {
    resource_group_name  = "tf_state" 
    storage_account_name = "tfstate019"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

```

### Tools

* Access to an existing Azure cloud as a owner or a developer.
* Bash and common command line tools (Make, etc.)
* [Terraform v0.14.0+](https://www.terraform.io/downloads.html)
* [AZ cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) that matches the latest generally-available EKS cluster version.

#### Install Terraform

Terraform is used to automate the manipulation of cloud infrastructure. Its [Terraform installation instructions](https://www.terraform.io/intro/getting-started/install.html) are also available online.

#### Install kubectl

Kubernetes uses a command line utility called kubectl for communicating with the cluster API server. The kubectl binary is available in many operating system package managers, and this option is often much easier than a manual download and install process. Follow the instructions to install [kubectl installation instructions](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html).

### Configure AZ CLI

After Installing the Azure CLI, Please follow the Installation Instructions to configure cli. [run-the-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli#run-the-azure-cli)

```console
az login
```

## Test this project locally

Export the following terraform environment variables(TFVARS) for terraform to create the resources. 
```console
# Environment
export TF_VAR_environment=<ENVIRONMENT_REPLACEME>
ex:- export TF_VAR_environment=dev

# Resource name prefix
export TF_VAR_name=<CLUSTERNAME_REPLACEME>
ex:- export TF_VAR_name=k8ssandra

# Location
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

Run the following commands to apply changes to your infrastructure.

```console
terraform plan
terraform apply
```

To destroy the resource, use the following instructions:

Create your workspace with the environment name, it is the recommended way of working with the Terraform workspaces among your teams. Select the workspace where resources need to be destroyed.

It is important to export the same values when destroying the resources on a workspace. Make sure you exported the right environment variables (TF_VAR).

```console
terraform workspace select <WORKSPACENAME_REPLACEME>
```
verify the resources before you destroy Used the following command.

```console
terraform plan -destroy
```

Run the following command to destroy all the resources in your workspace. 

```console
terraform destroy
```
or 
```console
terraform destroy -auto-approve
```
