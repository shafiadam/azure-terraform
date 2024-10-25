output "subnet_id" {
  value = azurerm_subnet.subnet.id
  description = "The ID of the subnet for use in other modules"
}