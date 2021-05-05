## Standards

Terraform resource naming style Guide to follow
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
