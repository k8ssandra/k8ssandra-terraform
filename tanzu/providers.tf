terraform {
  required_providers {
    vsphere = "~> 1.16"
    local = "~> 1.4"
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

terraform {
  required_version = ">= 0.12.0"
}
