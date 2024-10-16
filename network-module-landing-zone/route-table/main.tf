resource "azurerm_route_table" "public_route_table" {
  name                = "public-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "InternetRoute"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }
}
