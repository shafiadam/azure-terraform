///////azurerm_nat_gateway/////

resource "azurerm_public_ip" "main_nat_gateway_public_ip" {
  name                = var.nat_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "main_nat_gateway" {
  name                    = var.main_nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group_name
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gy_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.main_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.main_nat_gateway_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.main_nat_gateway.id
}