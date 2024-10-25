output "network_security_group_nsg" {
  value = azurerm_network_security_group.nsg.id
  description = "Network security group id"
}