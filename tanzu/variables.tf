variable "vsphere_user" {
  type    = string
  default = "administrator@vsphere.local"
}

variable "vsphere_password" {
  type = string
}

variable "vsphere_server" {
  type = string
}

variable "datacenter" {
  type    = string
  default = "Datacenter"
}

variable "cluster" {
  type    = string
  default = "Cluster"
}

variable "datastore" {
  type    = string
  default = "LUN01"
}

variable "datastore_url" {
  type = string
}

variable "vm_folder" {
  type    = string
  default = "tkg"
}

variable "resource_pool" {
  type    = string
  default = "TKG"
}

variable "network" {
  type    = string
  default = "VM Network"
}

variable "tkg_cli_file_name" {
  type    = string
  default = "tkg-linux-amd64-v1.0.0+vmware.1.gz"
}

variable "ubuntu_template" {
  type    = string
  default = "bionic-server-cloudimg-amd64"
}

variable "http_proxy_host" {
  type    = string
  default = ""
}

variable "http_proxy_port" {
  type    = number
  default = 0
}