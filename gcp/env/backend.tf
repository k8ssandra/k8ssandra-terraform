terraform {
  backend "gcs" {
    bucket = "tf-state-files-k8ssandra-testing"
    prefix = "terraform/"
  }
}
