terraform {
  backend "s3" {
    bucket = "k8ssandra-terraform-statefiles"
    key    = "terraform/"
  }
}
