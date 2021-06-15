# K8ssandra GCP Terraform Example

## What is Google Kubernetes Engine (GKE)?
[Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine) or "GKE" is a Google-managed Kubernetes environment. GKE is a fully managed experience; it handles the management/upgrading of the Kubernetes cluster master as well as Autoscaling of "nodes" through "node pool" templates.

Through GKE, your Kubernetes deployments will have first-class support for GCP IAM identities, built-in configuration of high-availability and secured clusters, as well as native access to GCP's networking features such as load balancers.

## What is GKE Node Pool ?
GKE Node Pools are a group of nodes who share the same configuration, defined as a NodeConfig. Node pools also control the Autoscaling of their nodes, and Autoscaling configuration is done inline, alongside the node config definition. A GKE Cluster can have multiple node pools defined. Initially by default we have only defined a `1` node pool. 

## VPC Network 
You must explicitly specify the network and subnetwork of your GKE cluster using the network and subnetwork fields; We will not use the default network with an automatically generated subnetwork.


## GCP resources created
* GKE cluster
* Cluster node pool
* Service account 
* Iam members 
* Google compute network(VPC)
* Subnet
* Router
* Compute router NAT
* Google storage bucket
* Google storage bucket IAM member


## Project directory Structure
<pre>
gcp/
 ├──modules/
 |  ├──<a href="modules/gcs/README.md">gcs</a>
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
 |  ├──<a href="modules/gke/README.md">gke</a>
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
    └── variables.tf 
    └── outputs.tf
    └── README.md
 ├──<a href="gcp/scripts/README.md">scripts</a>
</pre>

## Prerequisites

|       NAME        |   Version  | 
|-------------------|------------|
| Terraform version |   0.14     |
| GCP provider      |   ~>3.0    |
| Helm version      |   v3.5.3   |
| Google Cloud SDK  |   333.0.0  |
|    bq             |   2.0.65   |
|   core            | 2021.03.19 |
|  gsutil           |    4.60    |
|  kubectl          |  1.17.17   |

The steps to create Kubernetes cluster in this document require the following tools installation and configuration to access Google cloud resources.

### Cloud project

You will need a google cloud project created, If you do not have a google cloud account please signup [google](https://cloud.google.com).  

### Required GCP APIs

The following APIs are enabled when the terraform is utilized:

* Compute Engine API
* Kubernetes Engine API
* Cloud SQL Admin API
* Secret Token API
* Stackdriver Logging API
* Stackdriver Monitoring API
* IAM Service Account Credentials API

Execute the following commands on the Linux machine in order to setup gcloud cli.

```console
gcloud init
```
### GCP Quotas

If you created your Google cloud account newly, Google Compute Engine enforces quotas on resource usage for a variety of reasons. For example, quotas protect the community of Google Cloud users by preventing unforeseen spikes in usage, Google keep some soft limitations on the resources, you can always make a request to increase your quota limit. If you are planning to deploy k8ssandra cluster on GKE, you will need to make a request to increase your **Compute Engine API (backend services)** quota to `50` for the future use.

### Backend
  * Terraform uses persistent state data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.
  * Terraform backend configuration: 
  [Configuring your backend in gcs](https://www.terraform.io/docs/language/settings/backends/gcs.html)
  * Terraform state
  [How Terraform state works](https://www.terraform.io/docs/language/state/index.html)

Sample template to configure your backend in gcs bucket:
```
  terraform {
    backend "gcs" {
      bucket = "<REPLACEME_bucket_name>"
      prefix = "<REPLACEME_bucket_key>"
    }
  }
``` 

### Tools

* Access to an existing Google Cloud project as a owner or a developer.
* Bash and common command line tools (Make, etc.)
* [Terraform v0.14.0+](https://www.terraform.io/downloads.html)
* [gcloud v333.0.0+](https://cloud.google.com/sdk/downloads)
* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) that matches the latest generally-available GKE cluster version.

#### Install Terraform

Terraform is used to automate the manipulation of cloud infrastructure. Its [Terraform installation instructions](https://www.terraform.io/intro/getting-started/install.html) are also available online.

#### Install Cloud SDK

The Google Cloud SDK is used to interact with your GCP resources. [Google cloud SDK Installation instructions](https://cloud.google.com/sdk/downloads) for multiple platforms are available online.


### GCP-authentication

Ensure you have authenticated your gcloud client by running the following command:

```console
gcloud auth login
```

If you are already using another profile on your machine, use the following command to update the credentials:

```console
gcloud auth application-default login
```
#### Install Kubectl
The kubectl CLI is used to interact with both Kubernetes Engine and Kubernetes in general. Use the following command to install kubectl using gcloud:

```console
# install Kubectl 
gcloud components install kubectl.
```

### Configure-gcloud-settings

Run `gcloud config list` and make sure that `compute/zone`, `compute/region` and `core/project` are populated with values that work for you. You can choose a [region and zone near you](https://cloud.google.com/compute/docs/regions-zones/). You can set their values with the following commands:

```console
# Where the region is us-central1
gcloud config set compute/region us-central1

Updated property [compute/region].
```

```console
# Where the zone inside the region is us-central1-c
gcloud config set compute/zone us-central1-c

Updated property [compute/zone].
```

```console
# Where the project name is "my-project-name"
gcloud config set project "my-project-name"

Updated property [core/project].
```

## Test this project locally

Export the following terraform environment variables(TFVARS) for terraform to create the resources. 
```console

export TF_VAR_environment=<ENVIRONMENT_REPLACEME>
ex:- export TF_VAR_environment=dev

export TF_VAR_name=<CLUSTERNAME_REPLACEME>
ex:- export TF_VAR_name=k8ssandra

export TF_VAR_project_id=<PROJECTID_REPLACEME>
ex:- export TF_VAR_project_id=k8ssandra-testing

export TF_VAR_region=<REGION_REPLACEME>
ex:- export TF_VAR_region=us-central-1

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

### Install k8ssandra on the kubernetes cluster references documents 

https://k8ssandra.io/docs/getting-started/

Some Links for reference

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

https://github.com/k8ssandra/cass-operator/tree/master/docs/user#define-a-storage-class

helm repo add k8ssandra https://helm.k8ssandra.io/stable

helm repo add traefik https://helm.traefik.io/traefik

helm install -f k8ssandra.yaml k8ssandra k8ssandra/k8ssandra
