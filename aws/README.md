# K8ssandra AWS Terraform Module

## What is Elastic Kubernetes Service(EKS)?
[Amazon Elastic Kubernetes Service](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html) is a managed Kubernetes service on AWS, it gives user flexibility to run and scale Kubernetes applications in the AWS cloud.


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
 |
 ├──<a href="env/README.md">env</a>
 |   ├── dev.tf
 |    ../modules/vpc
 |    ../modules/iam
 |    ../modules/eks
 |    ../modules/s3
 |  ├── version.tf 
 |  └── variables.tf 
 |  └── outputs.tf
 |  └── README.md
 |
 ├──<a href="scripts/README.md">scripts</a>
 |  ├── apply.sh
 |  └── common.sh
 |  └── delete_bucket.py
 |  └── destroy.sh
 |  └── init.sh
 |  └── make_bucket.py
 |  └── plan.sh
 |  └── README.md
 └──README.md
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

### Backend
  * Terraform uses persistent state data to keep track of the resources it manages. Since it needs the state in order to know which real-world infrastructure objects correspond to the resources in a configuration, everyone working with a given collection of infrastructure resources must be able to access the same state data.
  * Terraform backend configuration: 
  [Configuring your backend in aws s3](https://www.terraform.io/docs/language/settings/backends/s3.html)
  * Terraform state
  [How Terraform state works](https://www.terraform.io/docs/language/state/index.html)

Following Backend template is to store your backend remotely in s3 bucket, if you are planning to use remote backend copy the following sample template to [./env](#./env) folder and update the backend file with your bucket name, key and your bucket region.

If you don't want to use the remote backend, you can use the local local directory to store the state files. `terraform init` will generate a state file and it will be stored in your local directory under [./env/.terraform](./env).

Sample template to configure your backend in s3 bucket:
```
  terraform {
    backend "s3" {
      bucket = "<REPLACEME_bucket_name>"
      key    = "<REPLACEME_bucket_key>"
      region = "<REPLACEME_region>"
    }
  }
```

### Access

* Access to an existing AWS cloud as a owner or a developer. following permissions are required 
  * Managed policies( These policies are Managed by the AWS, you can locate them in the attach existing policies section).
    * AmazonEKSClusterPolicy
    * AmazonEKSWorkerNodePolicy
    * AmazonEKSServicePolicy
    * AmazonEKSVPCResourceController
  * Custom policy document located here.[policy_document](#./scripts/policy_document.json). In this JSON file there are three different policy documents. 
    * [IAM-Developer](#./scripts/policy_document.json/policy-for-IAM) Policy to manage IAM access to the user.
    * [AutoScaling Group](#./scripts/policy_document.json/Policy-for-AutoScaling-Group) Policy to manage AutoScaling Group access permissions.
    * [EC2&S3_policy](#./scripts/policy_document.json/policy-for-S3-and-EC2) Policy to manage EC2 and S3 permissions.
    you will need to create three different policies, we cannot able to add all the policies in the single document, it will exceeds the resource limit on the policy document.

### Tools

* Bash and common command line tools (Make, etc.)
* [Terraform v0.14.0+](https://www.terraform.io/downloads.html)
* [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) that matches the latest generally-available EKS cluster version.

#### Install Terraform

Terraform is used to automate the manipulation of cloud infrastructure. Its [Terraform installation instructions](https://www.terraform.io/intro/getting-started/install.html) are also available online.

#### AWS IAM authenticator

Amazon EKS uses IAM to provide authentication to your Kubernetes cluster through the AWS IAM authenticator for Kubernetes. Follow the instructions to install [aws-iam-authenticator installation instructions](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).

#### Install kubectl
Kubernetes uses a command-line utility called `kubectl` for communicating with the cluster API server. The kubectl binary is available in many operating system package managers, and this option is often much easier than a manual download and install process. Follow the instructions to install [kubectl installation instructions](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html).

### Configure AWSCLI
Run `aws configure` command to configure your AWS cli, This Terraform module utilizes AWS CLI v2, if you have older versions of AWS CLI use the following instructions to uninstall older versions.

* [Uninstall AWS cli v1](https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html)
* [Install AWS cli v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

```console
aws configure
```
Enter `access key`, `secret access key` default `region`.

## Test this project locally

Export the following terraform environment variables(TFVARS) for terraform to create the resources. if you don't want to export any values, you skip this part and proceed further. 

```console

# Environment name, eg. "dev"
# bash, zsh
export TF_VAR_environment=dev

#fish
set -x TF_VAR_environment dev

# Kubernetes cluster name, eg. "k8ssandra"
# bash, zsh
export TF_VAR_name=k8ssandra

#fish
set -x TF_VAR_name k8ssandra

# Resource Owner name, eg. "k8ssandra"
# bash, zsh
export TF_VAR_resource_owner=k8ssandra

#fish
set -x TF_VAR_resource_owner k8ssandra


# AWS region name, eg. "us-east-1" 
# bash, zsh
export TF_VAR_region=us-east-1

#fish
set -x TF_VAR_region us-east-1

```

Important: Initialize the terraform modules and downloads required providers.

```console
cd env/

terraform init
```

Run the following commands to plan and apply changes to your infrastructure.

If you miss export any values or don't want to import any values, by running the following commands they are going prompt for required values in the `variable.tf`. you can enter those values through command-line.

```console 
terraform plan

terraform apply
```

**To destroy the resource, use the following instructions:**

It is important to export or pass the right values when destroying the resources on a local workspace. Make sure you exported(TF_VAR) or enter right environment variables.

Verify the resources before you destroy Used the following command.

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

## Setup AWS Ingress Controller
OpenID Connect (OIDC) Identity Provider (IDP) This feature allows customers to integrate an OIDC identity provider with a new or existing Amazon EKS cluster running Kubernetes version 1.16 or later. The OIDC IDP can be used as an alternative to, or along with AWS Identity and Access Management (IAM). With this feature, you can manage user access to your cluster by leveraging existing identity management life cycle through your OIDC identity provider.

**enable OIDC provider:**
```console
eksctl utils associate-iam-oidc-provider --region <REPLACEME_region> --cluster <REPLACEME_cluster_name> --approve
```
eg:- eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster dev-k8ssandra-eks-cluster --approve


**create IAM policy:**
Locate the IAM policy document and provide path and create a policy, If the policy exists skip to the next step
```console
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://<path>iam_policy.json
```
Get the ARN of the IAM policy, save it for future use.

eg:- aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

**create a service account user the policy arn create above:**

Get the Account number
```console
aws sts get-caller-identity
```
Get the policy ARN we created earlier. ARN of the policy example
eg:- arn:aws:iam::xxxxxxxxxxxx:policy/AWSLoadBalancerControllerIAMPolicy

Create an IAM role and annotate the Kubernetes service account named aws-load-balancer-controller in the kube-system namespace for the AWS Load Balancer Controller using eksctl or the AWS Management Console and kubectl.

```console
eksctl create iamserviceaccount --cluster=<REPLACEME_clustername> --region=<REPLACEME_region> --namespace=kube-system --name=aws-load-balancer-controller --attach-policy-arn=arn:aws:iam::xxxxxxxxxxxx:policy/AWSLoadBalancerControllerIAMPolicy --override-existing-serviceaccounts --approve
```

eg:-
eksctl create iamserviceaccount --cluster=dev-k8ssandra-eks-cluster --region=us-east-1 --namespace=kube-system --name=aws-load-balancer-controller --attach-policy-arn=arn:aws:iam::xxxxxxxxxxx:policy/AWSLoadBalancerControllerIAMPolicy --override-existing-serviceaccounts --approve

If you currently have the AWS ALB Ingress Controller for Kubernetes installed, uninstall it. The AWS Load Balancer Controller replaces the functionality of the AWS ALB Ingress Controller for Kubernetes.

**Install the AWS Load Balancer Controller using Helm V3 or later:**
Install the TargetGroupBinding custom resource definitions.
```console
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
```

**Add the eks-charts repository:**
```console
helm repo add eks https://aws.github.io/eks-charts
```
Update your local repo to make sure that you have the most recent charts
```console
helm repo update
```

**Install the AWS Load Balancer Controller:**
Install aws-load-balancer-controller by using helm command

```console
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=<REPLACEME_cluster_name> -n kube-system --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
```
eg :-
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=dev-k8ssandra-eks-cluster -n kube-system --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

**Check the deployment status:**
```console
kubectl get deployment -n kube-system aws-load-balancer-controller
```
Check the deployment status you should see the following output.

Output:-
NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
aws-load-balancer-controller   2/2     2            2           84s

**check the logs:**
```console
kubectl logs -n kube-system   deployment.apps/aws-load-balancer-controller
```

### Deploy K8ssandra

Add the following helm repo's if there are not already added.
```console
helm repo add k8ssandra https://helm.k8ssandra.io/stable
```

### Installation 
Deploy k8ssasndra by running the following command.
```console
helm install <REPLACEME_release-name> k8ssandra/k8ssandra --set cassandra.cassandraLibDirVolume.storageClass=gp2

eg: helm install test k8ssandra/k8ssandra --set cassandra.cassandraLibDirVolume.storageClass=gp2
```
After the installation please verify the pods status, it will take about 3-5 minutes provision the resources wait until all the resources are in running state.

to check the status of the pods run the following command, wait until all the pods and services available.

```console
kubectl get pods
```

### Create Nodeport
locate `nodeport.yaml` file and run the following command to create Nodeport service.
```console
kubectl create -f /nodeport.yaml
```

### Create ingress:
```console
cd test
kubectl create -f /ingress.yml
```
Wait for the load balancers to come available
```console
kubectl get ingress
```

Output:
NAME             CLASS    HOSTS   ADDRESS                                                                 PORTS   AGE
ingress          <none>   *       k8s-default-ingress-7cb30059ab-318290427.us-east-1.elb.amazonaws.com    80      38m

When you create an Amazon EKS cluster, the IAM user or role (such as a federated user that creates the cluster) is automatically granted system:masters permissions in the cluster's RBAC configuration. If you access the Amazon EKS console and your IAM user or role isn't part of the aws-auth ConfigMap, then you can't see your Kubernetes workloads or overview details for the cluster.

To grant additional AWS users or roles the ability to interact with your cluster, you must edit the aws-auth ConfigMap within Kubernetes.

### Map the IAM users or roles to the RBAC roles and groups using aws-auth ConfigMap

**Get the configuration of your AWS CLI user or role:**

```console
aws sts get-caller-identity
```
Confirm that the ARN matches the cluster creator or the admin with primary access to configure your cluster. If the ARN doesn't match the cluster creator or admin, then contact the cluster creator or admin to update the aws-auth ConfigMap.

The group name in the [manifest](../scripts/manifest.yaml) file is `eks-console-dashboard-full-access-group`. This is the group that your IAM user or role must be mapped to in the aws-auth ConfigMap.

**To create a cluster role and cluster role binding:** 

Deploy the manifest file: Use the [manifest](../scripts/manifest.yaml) file.
```console
kubectl apply -f manifest.yaml
```

**Verify the creation of cluster role and cluster role binding objects:**
```console
kubectl describe clusterrole.rbac.authorization.k8s.io/eks-console-dashboard-full-access-clusterrole
kubectl describe clusterrolebinding.rbac.authorization.k8s.io/eks-console-dashboard-full-access-binding
```

To edit aws-auth ConfigMap in a text editor, the cluster creator or admin must run the following command:

```console
kubectl edit configmap aws-auth -n kube-system
```

**To add an IAM user or IAM role, complete either of the following steps.**

**Important:** mapUsers[].groups.`eks-console-dashboard-full-access-group`. Group name must be the same as the group name created in the [manifest](../scripts/manifest.yaml) file.

```console
Add the IAM user to mapUsers. For example:

mapUsers: |
  - userarn: arn:aws:iam::XXXXXXXXXXXX:user/<REPLACEME_username>
  username: <REPLACEME_username>
  groups:
    - system:bootstrappers
    - system:nodes
    - eks-console-dashboard-full-access-group
```

-or-

```console
Add the IAM role to mapRoles. For example:

mapRoles: |
  - rolearn: arn:aws:iam::XXXXXXXXXXXX:role/<REPLACEME_role_name>
  username: <REPLACEME_role_name>
  groups:
    - system:bootstrappers
    - system:nodes
    - eks-console-dashboard-full-access-group
```

### Verify access to your Amazon EKS cluster
login to the AWS management console, Select your cluster on the navigation pane and Check the Overview and Workloads tabs for errors. You shouldn't see any errors.

## Debugging:
Helpful links to resolve issues on the EKS cluster access:
https://aws.amazon.com/premiumsupport/knowledge-center/eks-kubernetes-object-access-error/
