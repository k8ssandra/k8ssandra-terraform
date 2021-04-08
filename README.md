## Standerdization 

terraform Style Guide to follow
https://github.com/jonbrouse/terraform-style-guide/blob/master/README.md#resource-naming

Linting and Verifications standards to be checked with the following commands depending on the file type:

### Terraform
```
terraform fmt -check [-recursive]
terraform validate
tfsec
```

### BASH (.sh files)
```
shellcheck [.sh files]
```

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