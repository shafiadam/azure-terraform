variable "resource_group_name_prefix" {
  description = "The prefix for the resource group name"
  default     = "your_default_prefix"
}

variable "resource_group_location" {
  description = "The location for the resource group"
  default     = "your_default_location"
}

variable "vm_name" {
  description = "The name for the virtual machine"
  default     = "myVM"
}

variable "vm_size" {
  description = "The size of the virtual machine"
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  default     = "adminuser"
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  default     = "Reddeadredemption2"
}

variable "os_disk_name" {
  description = "The name for the OS disk"
  default     = "myOsDisk"
}

variable "os_disk_caching" {
  description = "The caching type for the OS disk"
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "The storage account type for the OS disk"
  default     = "Premium_LRS"
}

variable "source_image_publisher" {
  description = "The publisher for the source image"
  default     = "Canonical"
}

variable "source_image_offer" {
  description = "The offer for the source image"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "source_image_sku" {
  description = "The SKU for the source image"
  default     = "22_04-lts-gen2"
}

variable "source_image_version" {
  description = "The version for the source image"
  default     = "latest"
}

variable "computer_name" {
  description = "The computer name for the virtual machine"
  default     = "myvm"
}

variable "disable_password_authentication" {
  description = "Whether to disable password authentication"
  default     = false
}

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }
  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }
  computer_name                   = var.computer_name
  disable_password_authentication = var.disable_password_authentication
}
