resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = var.ddos_protection_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
}