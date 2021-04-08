# K8ssandra GCP Terraform Example

## GCP resources
* GKE cluster
* Cluster node pool
* service account 
* iam member 
* custom iam member
* google compute network(VPC)
* public subnet
* private subnet
* router
* compute router nat
* google storage bucket
* google storage bucket iam member
* google compute address


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
    └── backend.tf 
    └── variables.tf 
    └── outputs.tf
    └── README.md
</pre>

## Prerequisites

|       NAME        |   Version  | 
|-------------------|------------|
| terraform version |   0.14     |
| gcp provider      |   ~>3.0    |
| Helm version      |   v3.5.3   |
| Google Cloud SDK  |   333.0.0  |
|    bq             |   2.0.65   |
|   core            | 2021.03.19 |
|  gsutil           |    4.60    |
|  kubectl          |  1.17.17   |

The steps to create kubernetes cluster in this document require the following tools installation and configuration to access Google cloud resources.

### Cloud project

You will need a google cloud project created, If you do not have a google cloud account plese sigup [google](https://cloud.google.com).  

### Required GCP APIs

The following APIs will be enabled:

* Compute Engine API
* Kubernetes Engine API
* Cloud SQL Admin API
* Secret Token API
* Stackdriver Logging API
* Stackdriver Monitoring API
* IAM Service Account Credentials API

All the tools for the demo are installed. When using Cloud Shell execute the following command in order to setup gcloud cli. When executing this command please setup your region and zone.

```console
gcloud init
```

### Tools

When not using Cloud Shell, the following tools are required:

* Access to an existing Google Cloud project.
* Bash and common command line tools (Make, etc.)
* [Terraform v0.14.0+](https://www.terraform.io/downloads.html)
* [gcloud v333.0.0+](https://cloud.google.com/sdk/downloads)
* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) that matches the latest generally-available GKE cluster version.

#### Install Terraform

Terraform is used to automate the manipulation of cloud infrastructure. Its [Terraform installation instructions](https://www.terraform.io/intro/getting-started/install.html) are also available online.

#### Install Cloud SDK

The Google Cloud SDK is used to interact with your GCP resources. [Google cloud SDK Installation instructions](https://cloud.google.com/sdk/downloads) for multiple platforms are available online.

#### Install kubectl CLI

The kubectl CLI is used to interteract with both Kubernetes Engine and Kubernetes in general. [kubectl CLI Installation instructions](https://cloud.google.com/kubernetes-engine/docs/quickstart) for multiple platforms are available online.


### Authenticate gcloud

Prior to running this demo, ensure you have authenticated your gcloud client by running the following command:

```console
gcloud auth login
```

### Configure gcloud settings

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

```
cd env/
terraform init
````
After the terraform initialization is successful, create your workspace and by using the following command

```
terraform workspace new <WORKSPACENAME>
```

or select the workspace if there are any existing workspaces

```
terraform workspace select <WORKSPACENAME>
```

Update variables.tf and setup your project ID

run the following commands

```
terraform plan
terraform apply
```
```

### Install k8ssandra on the kubernetes cluster references documents 

https://k8ssandra.io/docs/getting-started/

Some Links for reference

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

https://github.com/k8ssandra/cass-operator/tree/master/docs/user#define-a-storage-class

helm repo add k8ssandra https://helm.k8ssandra.io/stable

helm repo add traefik https://helm.traefik.io/traefik

helm install -f k8ssandra.yaml k8ssandra k8ssandra/k8ssandra
