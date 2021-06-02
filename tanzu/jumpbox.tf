# Generate TKG configuration.
resource "local_file" "tkg_configuration_file" {
    content = templatefile("tkg-cluster.yml.tpl", {
      vcenter_server       = var.vsphere_server,
      vcenter_user         = var.vsphere_user,
      vcenter_password     = var.vsphere_password,
      datacenter           = var.datacenter,
      datastore            = var.datastore,
      network              = var.network,
      resource_pool        = var.resource_pool,
      vm_folder            = var.vm_folder
    })
    filename        = "tkg-cluster.yml"
    file_permission = "0644"
}

# Generate additional configuration file.
resource "local_file" "env_file" {
    content = templatefile("env.tpl", {
      http_proxy_host = var.http_proxy_host,
      http_proxy_port = var.http_proxy_port
    })
    filename        = "env"
    file_permission = "0644"
}

# Use the jumpbox to access TKG from the outside.
resource "vsphere_virtual_machine" "jumpbox" {
  name             = "jumpbox"
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  # Older versions of VMware tools do not return an IP address:
  # get guest IP address instead.
  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = 2

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"
  folder   = vsphere_folder.vm_folder.path

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu_template.id

    # Do not include a "customize" section here:
    # this feature is broken with current Ubuntu Cloudimg templates.
  }

  # A CDROM device is required in order to inject configuration properties.
  cdrom {
    client_device = true
  }

  vapp {
    properties = {
      "instance-id" = "jumpbox"
      "hostname"    = "jumpbox"
      
      # Use our own public SSH key to connect to the VM.
      "public-keys" = file("~/.ssh/id_rsa.pub")
    }
  }

  connection {
      host        = vsphere_virtual_machine.jumpbox.default_ip_address
      timeout     = "30s"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
  }
  provisioner "file" {
    # Copy TKG binary CLI.
    source      = var.tkg_cli_file_name
    destination = "/home/ubuntu/tkg.tgz"
  }
  provisioner "file" {
    # Copy TKG configuration file.
    source      = "tkg-cluster.yml"
    destination = "/home/ubuntu/tkg-cluster.yml"
  }
  provisioner "file" {
    # Copy additional configuration file.
    source      = "env"
    destination = "/home/ubuntu/.env"
  }
  provisioner "file" {
    # Copy install scripts.
    source      = "setup-jumpbox.sh"
    destination = "/home/ubuntu/setup-jumpbox.sh"
  }
  provisioner "remote-exec" {
    # Set up jumpbox.
    inline = [
      "echo ${vsphere_virtual_machine.jumpbox.default_ip_address} jumpbox | sudo tee -a /etc/hosts",
      "chmod +x /home/ubuntu/setup-jumpbox.sh",
      "sh /home/ubuntu/setup-jumpbox.sh ",
    ]
  }
}

output "jumpbox_ip_address" {
  value = vsphere_virtual_machine.jumpbox.default_ip_address
}