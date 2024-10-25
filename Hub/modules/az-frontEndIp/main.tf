//////PublicIp/Frontend//
resource "azurerm_public_ip" "frontend_Ip" {
  name                = var.ipname
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}