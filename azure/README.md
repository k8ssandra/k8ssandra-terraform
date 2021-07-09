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
* Application gateway
* Role assignments

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
 |
 ├──<a href="scripts/README.md">scripts</a>
 |  ├── apply.sh
 |  └── common.sh
 |  └── delete_storage_account.py
 |  └── destroy.sh
 |  └── init.sh
 |  └── create_storage_account.py
 |  └── plan.sh
 |  └── README.md
 └──README.md
</pre>

## Prerequisites

|       NAME          |   Version  | 
|---------------------|------------|
| Terraform version   |   0.14     |
| Azurerm provider    |   ~>2.49.0 |
| Helm version        |   v3.5.3   |
| AZ CLI              |  ~>2.22.1  |   
| kubectl             |  ~>1.17.17 |
| python              |    3       |

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
ex:- export TF_VAR_region=eastus

# Location
export TF_VAR_resource_owner=<REGION_REPLACEME>
ex:- export TF_VAR_resource_owner=k8ssandra
```

Important: Initialize the terraform modules delete the backend file for local testing.

```console
cd env/
terraform init
````

Run the following commands to apply changes to your infrastructure.

```console
terraform plan
terraform apply
```

To destroy the resource, use the following instructions:
It is important to export the same values when destroying the resources. Make sure you exported the right environment variables (TF_VAR).

```console
terraform plan -destroy
```

Run the following command to destroy all the resources in your local workspace.

```console
terraform destroy
```
or 
```console
terraform destroy -auto-approve
```

## Setup Ingress controller
After `terraform apply` an application gateway will be configured

Get the Kubernetes configuration and access credentials from the Azure using the Azure CLI command.

```console
az aks get-credentials --name <REPLACEME_AksCluserName>  --resource-group <REPLACEME_ResourceGroupName>
```
eg:- az aks get-credentials --name dev-k8ssandra-eks-cluster  --resource-group dev-k8ssandra-resource-group

verify the health and status of the cluster nodes

```console
kubectl get nodes
```
### Install Azure AD Pod Identity
Azure Active Directory Pod Identity provides token-based access to Azure Resource Manager.

AAD Pod Identity enables Kubernetes applications to access cloud resources securely with Azure Active Directory.

Using Kubernetes primitives, administrators configure identities and bindings to match pods. Then without any code modifications, your containerized applications can leverage any resource in the cloud that depends on AAD as an identity provider.

If RBAC is enabled, run the following command to install Azure AD Pod Identity to your cluster:

```console
kubectl create -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment-rbac.yaml
```
If RBAC is disabled, run the following command to install Azure AD Pod Identity to your cluster:

```console
kubectl create -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment.yaml
```

### Install Helm
The code in this section uses Helm - Kubernetes package manager - to install the application-gateway-kubernetes-ingress package:

Run the follow helm commands to add the AGIC Helm repository:

```console
helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update
```

### Install Ingress Controller Helm Chart
Locate the [helm-config.yaml](./scripts/helm-config.yaml) file in the scripts folder.

The values are described as follows:

**verbosityLevel:** Sets the verbosity level of the AGIC logging infrastructure. See Logging Levels for possible values.
**appgw.subscriptionId:** The Azure Subscription ID for the App Gateway. Example: a123b234-a3b4-557d-b2df-a0bc12de1234
**appgw.resourceGroup:** Name of the Azure Resource Group in which App Gateway was created.
**appgw.name:** Name of the Application Gateway. Example: applicationgateway1.
**appgw.shared:** This boolean flag should be defaulted to false. Set to true should you need a Shared App Gateway.
**kubernetes.watchNamespace:** Specify the name space, which AGIC should watch. The namespace can be a single string value, or a comma-separated list of namespaces. Leaving this variable commented out, or setting it to blank or empty string results in Ingress Controller observing all accessible namespaces.
**armAuth.type:** A value of either aadPodIdentity or servicePrincipal.
**armAuth.identityResourceID:** Resource ID of the managed identity.
**armAuth.identityClientId:** The Client ID of the Identity.
**armAuth.secretJSON:** Only needed when Service Principal Secret type is chosen (when armAuth.type has been set to servicePrincipal).

**Key notes:**

The <identityResourceID> value is created in the terraform script and can be found by running: 
```console
echo "$(terraform output identity_resource_id)"
```
The <identityClientID> value is created in the terraform script and can be found by running: 
```console
echo "$(terraform output identity_client_id)"
```
The <resource-group> value is the resource group of your App Gateway or it can be found by running:
```console
echo "$(terraform output resource_group)"
```

The <identity-name> value is the name of the created identity.
```console
echo "$(terraform output application_gateway_id)"
```

All identities for a given subscription can be listed using: az identity list. or it can be found by running: 
```console
echo "$(terraform output subcription_id)"
```

**Install the Application Gateway ingress controller package:**
Update the required variables in the `helm-config.yaml` file then run the following command, you can find all required values to update this file in the terraform outputs.
```console
helm install -f helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure --generate-name
```

## Install K8ssandra on the Azure Kubernetes Service

**Check the storage classes type by running the following command:**
check all the storage classes available in the Azure Kubernetes Cluster
```console
kubectl get storageclass
```

**Run the following command to add the k8ssandra helm repository:**
```console
helm repo add k8ssandra https://helm.k8ssandra.io/stable
helm repo update
```

**Run the following command to deploy the K8ssandra by using Helm command:**
```console
helm install <REPLACEME_release-name> k8ssandra/k8ssandra --set cassandra.cassandraLibDirVolume.storageClass=default
```
eg:- helm install test k8ssandra/k8ssandra --set cassandra.cassandraLibDirVolume.storageClass=default

**Create Nodeport & Ingress service:**
[nodeport.yaml](./scripts/nodeport.yaml) and [ingress.yaml](./scripts/nodeport) file will be found in the scripts folder.
run the following command to create Nodeport service and Ingress.
```console
kubectl create -f ./nodeport.yaml
kubectl create -f ./ingress.yaml
```
