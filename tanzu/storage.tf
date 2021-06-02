resource "local_file" "vsphere_storage_class" {
    content = templatefile("vsphere-storageclass.yml.tpl", {
      datastore_url = var.datastore_url,
    })
    filename        = "vsphere-storageclass.yml"
    file_permission = "0644"
}

resource "vsphere_folder" "vm_folder" {
  path          = var.vm_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
