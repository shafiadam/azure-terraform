/////Jumb box subnet /////
resource "azurerm_subnet" "JumpBox_Subnet" {
  name                 = "JumpboxSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.jumpbox_subnet
  depends_on = [
    var.resource_group_name
  ]
}


resource "azurerm_network_interface" "JumpBox" {
  name                = var.Jumpboxname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "JumpBox-ipconfiguration"
    subnet_id                     = azurerm_subnet.JumpBox_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}