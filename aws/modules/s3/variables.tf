# Variables to create S3 bucket
variable "name" {
  description = "The name to give the new Kubernetes cluster resources."
  type        = string
}

variable "environment" {
  description = "Name of the environment where infrastrure being built."
  type        = string
}

variable "tags" {
  description = "Common tags to attach all the resources create in this project."
  type        = map(string)
}