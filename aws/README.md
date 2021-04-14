# Auto Deploymemnt of EKS Infrastructure on AWS with Terraform

## Project Content
This project contains the three modules
* **cluster-autoscaler**: Contains yaml file of cluster-autoscaler to scale out ans scale down the EKS cluster nodes. 
* **aws**: Contains terraform scripts to deploy infrastructure in declarative format. 
* **HPA(Horizontal Pod Autoscaler)**: - To scale out and scale down the pods on nodes.

These scripts create the following infrastructure.
- EC2 Instances
- EKS Cluster
- Horizontal Pod AutoScaler
- Cluster AutoScaler



## Creating EKS cluster with Terraform Scripts
 - Prerequisite: kubectl & aws-iam-authenticator cli tools need to be installed
 
There are terraform scripts in "aws" folder. By running the following commands terraform creates.
EC2 instance and EKS cluster for us in the desired region. All the required configs are defined in respective script, 
like IAM roles, policies, security groups, etc.
