resource "azurerm_virtual_machine" "mgm_node" {
    name                  = "Ansible-Mgmnt-Node"
    location              = "westeurope"
    resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
    network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
    vm_size               = "Standard_A1"
    delete_os_disk_on_termination = true

    storage_os_disk {
        name              = "mgmOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "mgm-node"
        admin_username = "${var.adm_user}"
        admin_password = "${var.adm_passwd}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
#        ssh_keys {
#            path     = "/home/ansible/.ssh/authorized_keys"
#            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWGKEVpxC6MZGBoFn64tIvEMwCwW0NrlAcBE/5kdOjhfA7lCQl0qIhNdNz+erVACEtLDnFlamwG8D6Jgc08wNCk4Le7ifQ4OoX9F+42x9q22GBJFhZgP+3u9uOM7jp06/fkpiSUyJA0jy1tk7SCq+c8weWyOJnq8enDm65PooCHsS1XgyFubYKlF9a5aBl7L7P3gPZpdFxCZK+6wSjCtANXAQIVqiUQ73p3AvfIRXTg91KGQ0jKQ5zYiNpSTrWg/l0DDS5MD5+1sGV1rIpSDxdJEbneLocO8Blrgb5NRLcv3pqTYKTWzXWObaB0guHDDiLLpMvTWbuDlzH6b97mzrB root@terraform.local"
#        }
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
    }

#    depends_on = ["azurerm_public_ip.myterraformpublicip"]

    tags {
        
        ssh_user = "${var.adm_user}"
#        ssh_ip = "${azurerm_network_interface.myterraformnic.private_ip_address}"
        ssh_ip = "${azurerm_public_ip.myterraformpublicip.ip_address}"
        role = "myrole"

    }
}
