///////azurerm_route/////

resource "azurerm_route_table" "route_table" {
  name                    = var.route_table_name
  location                = var.location
  resource_group_name     = var.resource_group_name
}

resource "azurerm_route" "custom_route" {
  name                = var.custom_route_name
  resource_group_name =  var.resource_group_name
  route_table_name    = azurerm_route_table.route_table.name
  address_prefix      = var.subnet_address_spaces
  next_hop_type       = "VnetLocal"
}

resource "azurerm_subnet_route_table_association" "route_table_subnet_association" {
  subnet_id      = var.subnet_id 
  route_table_id = azurerm_route_table.route_table.id
}