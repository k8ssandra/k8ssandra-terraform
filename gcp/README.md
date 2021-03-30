# project_k8ssandra

## Standerdization 

terraform Style Guide to follow
https://github.com/jonbrouse/terraform-style-guide/blob/master/README.md#file-names


# folder Structure

k8ssandra-terraform/
  aws/
  
  gcp/
    modules/
      vpc/
        main.tf 
        variables.tf 
        outputs.tf 
        README.md 
      iam/
        main.tf 
        variables.tf 
        outputs.tf 
        README.md
      gke/
        main.tf 
        variables.tf 
        outputs.tf 
        README.md
    version.tf 
    backend.tf 
    variables.tf 
    outputs.tf
    README.md 
    env/
      dev.tf
      ../modules/vpc
      ../modules/iam
      ../modules/gke_cluster
  
  azure/
  tanzu/
  dev.tf


terraform version 0.14 
Helm version v3.5.3

### Google cloud
Google Cloud SDK 333.0.0
bq 2.0.65
core 2021.03.19
gsutil 4.60
kubectl 1.17.17

clone this repo, and to initialize the terraform run the following command

```
terraform init
````
after the terraform initialization is successful, create your workspace and by using the following command

```
terraform workspace new <WORKSPACENAME>
```

or select the workspace if there are any existing workspaces

```
terraform workspace select <WORKSPACENAME>
```

go to the variables.tf and update your project ID

run the following commands

```
terraform plan
terraform apply
```
after completed applying the changes connect kubernetes to your cluster through CLI

### GCP
ex:- gcloud container clusters get-credentials <Name of your Cluster> --region us-central1 --project <project ID>

To install k8ssandra on the kubernetes cluster go to the following documentation. 

https://k8ssandra.io/docs/getting-started/

Some Links for reference
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

helm repo add k8ssandra https://helm.k8ssandra.io/stable

helm repo add traefik https://helm.traefik.io/traefik

helm install -f k8ssandra.yaml k8ssandra k8ssandra/k8ssandra
