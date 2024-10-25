
//////////////Bastion////////////////
resource "azurerm_subnet" "Bastion_Subnet" {
  name                 = var.bastionsubnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.bastion_address_prefixes
  depends_on = [
    var.resource_group_name
  ]
}
resource "azurerm_public_ip" "Bastion_Ip" {
  name                = var.bastion_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_bastion_host" "Bastion_Host" {
  name                = var.bastionhostname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "bastion-configuration"
    subnet_id            = azurerm_subnet.Bastion_Subnet.id
    public_ip_address_id = azurerm_public_ip.Bastion_Ip.id
  }
  depends_on = [
    var.resource_group_name
  ]
}