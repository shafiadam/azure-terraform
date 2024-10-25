output "virtual_network_name" {
  value = azurerm_virtual_network.main_virtual_network.name
  description = "virtual network name for use in other modules"
}

