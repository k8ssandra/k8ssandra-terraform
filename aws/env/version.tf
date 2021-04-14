terraform {
  required_version = ">= 0.12"

  required_provider = {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "http" {
}
