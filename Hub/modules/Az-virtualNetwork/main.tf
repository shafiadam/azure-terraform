///virtual-network///
resource "azurerm_virtual_network" "main_virtual_network" {
  name                = var.vnetname
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["${var.vnet_address_space}"]

  ddos_protection_plan {
    id     = var.ddos_protect_id
    enable = true
  }
  tags = var.tags   
}