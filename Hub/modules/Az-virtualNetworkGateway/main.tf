resource "azurerm_public_ip" "main-vpn-gy1-pip" {
  name                = var.main_vpn_gateway_pip
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_subnet" "main-gy-subnet" {
  name                 = var.Gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.Gateway_subnet_prefix
  depends_on = [
    var.resource_group_name
  ]
}
resource "azurerm_virtual_network_gateway" "main-vnet-gy" {
  name                = var.Gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.Gateway_type
  vpn_type = var.Gateway_vpn_type

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.main-vpn-gy1-pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.main-gy-subnet.id
  }
}
