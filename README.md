# K8saandra Terraform
This repo contains a Terraform modules for creating Kubernetes clusters on Google Cloud Platform (GCP), Amazon Web Services(AWS), Microsoft Azure, Tanzu.

## What's in this repo

* [gcp](./gcp/README.md): Google cloud terraform module to create kubernetes cluster using Google Kubernetes Engine(GKE).
    * [env](./gcp/env/README.md) This folder contains modules, version, variables, output files. you will run all the terraform command from this folder.
    * [modules](./gcp/modules/README.md) This folder contains the main implementation code for this Module, broken down into multiple standalone submodules.
        * [gcs](./gcp/modules/gcs/README.md): Google Cloud Storage bucket module.
        * [vpc](./gcp/modules/vpc/README.md): Google Compute Network module.
        * [gke](./gcp/modules/gke/README.md): Google Kubernetes Engine module.
        * [iam](./gcp/modules/iam/README.md): Identity Access Management modules.
* [aws](./aws/README.md): Amazon Web Services terraform module to create kubernetes cluster using Elastic Kubernetes Service(EKS).
* [azure](./azure/README.md): Azure terraform module to create kubernetes cluster using Azure Kubernetes Service(AKS).
* [aws](./aws/README.md): Tanzu terraform module to create kubernetes cluster using Elastic Kubernetes Service.
* [test](./test): Automated tests for the files in this project repository.


## What is Kubernetes?
[Kubernetes](https://kubernetes.io/) is an open source container management system for deploying, scaling, and managing containerized applications. Kubernetes is built by Google based on their internal proprietary container management systems (Borg and Omega). Kubernetes provides a cloud agnostic platform to deploy your containerized applications with built in support for common operational tasks such as replication, autoscaling, self-healing, and rolling deployments.

## What is Manged Kubernetes services?
Managed Kubernetes is when third-party providers take over responsibility for some or all of the work necessary for the successful set-up and operation of K8s. Depending on the vendor, “managed” can refer to anything from dedicated support, to hosting with pre-configured environments, to full hosting and operation. We will be using GKE, AKS, EKS, Tanzu. 

## What is Terraform?
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions. We will be using terraform version 0.14 to provision out infrastructure.  

## What is a Terraform module?
A [Terraform Module](https://www.terraform.io/docs/language/modules/develop/index.html) is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such as a database or server cluster. Each Module is written using a combination of Terraform and scripts (mostly bash) and include automated tests, documentation, and examples. It is maintained both by the open source community and companies that provide commercial support.

Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself, you can leverage the work of the Module to pick up infrastructure improvements through a version number bump.


## GCP Prerequisites

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


## Project directory Structure
<pre>
k8ssandra-terraform/
|   aws/
|   gcp/
|    ├──modules/
|    |  ├──<a href="gcp/modules/gcs/README.md">gcs</a>
|    |     ├── main.tf 
|    |     └── variables.tf 
|    |     └── outputs.tf 
|    |     └── README.md 
|    |  ├──<a href="gcp/modules/vpc/README.md">vpc</a>
|    |     ├── main.tf 
|    |     └── variables.tf 
|    |     └── outputs.tf 
|    |     └── README.md 
|    |  ├──<a href="gcp/modules/iam/README.md">iam</a>
|    |     ├── main.tf 
|    |     └── variables.tf 
|    |     └── outputs.tf 
|    |     └── README.md
|    |  ├──<a href="gcp/modules/gke/README.md">gke</a>
|    |     ├── main.tf 
|    |     └── variables.tf 
|    |     └── outputs.tf 
|    |     └── README.md
|    └──README.md
|    └──gitignore
|    ├──<a href="gcp/env/README.md">env</a>
|       ├── dev.tf
|         ../modules/vpc
|         ../modules/iam
|         ../modules/gke_cluster
|       ├── version.tf 
|       └── backend.tf 
|       └── variables.tf 
|       └── outputs.tf
|       └── README.md
|  azure/
|  tanzu/
|  test/
|  scripts/
|  LICENSE
|  Makefile
|  README.md
</pre>

## Create GKE resources

* Testing this project Locally [gcp](./gcp#test-this-project-locally)

* How to create GKE cluster resources by using the make command
[ WORK IN PROGRESS ]

## Create EKS resources

* How to create EKS cluster resources by using the make command
[ WORK IN PROGRESS ]

## Create AKE resources
* How to create AKS cluster resources by using make command
[ work In progress] 


## Troubleshooting

* **The create script fails with a `Permission denied` when running Terraform** - The credentials that Terraform is using do not provide the necessary permissions to create resources in the selected projects. Ensure that the account listed in `gcloud config list` has necessary permissions to create resources. If it does, regenerate the application default credentials using `gcloud auth application-default login`.
* **Terraform timeouts** - Sometimes resources may take longer than usual to create and Terraform will timeout. The solution is to just run `make create` again. Terraform should pick up where it left off.

## Relevant Material

* [Private GKE Clusters](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)
* [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)
* [Terraform Google Provider](https://www.terraform.io/docs/providers/google/)
* [Securely Connecting to VM Instances](https://cloud.google.com/solutions/connecting-securely)
* [Cloud NAT](https://cloud.google.com/nat/docs/overview)
* [Kubernetes Engine - Hardening your cluster's security](https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster)
