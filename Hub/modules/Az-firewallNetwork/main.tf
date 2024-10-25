/////Fire Wall Network //////
resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.10.0/24"]
}
resource "azurerm_public_ip" "firewall_Ip" {
  name                = var.firewall_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

}
resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.firewall_sku_name
  sku_tier            = "Standard"
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_Ip.id
  }

}
resource "azurerm_firewall_network_rule_collection" "firewall_Rule" {
  name                = var.firewall_network_rule
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Deny"

  rule {
    name = "firewall_Rule"

    source_addresses = [
      "0.0.0.0",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "0.0.0.0",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}