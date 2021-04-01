terraform {
  backend "gcs" {
    bucket = "tf-state-datastax"
    prefix = "terraform/state"
  }
}
