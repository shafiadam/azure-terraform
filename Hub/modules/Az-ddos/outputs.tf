output "ddos_protect_id" {
  value = azurerm_network_ddos_protection_plan.ddos.id
  description = "The ID of the ddos protection for use in other modules"
}