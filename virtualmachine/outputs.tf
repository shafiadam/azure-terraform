output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}


output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

# output "azurerm_mysql_server" {
#   value = azurerm_mssql_server.server.fully_qualified_domain_name
# }
# output "mysql_server_database_name" {
#   value = azurerm_mssql_database.db.name
# }