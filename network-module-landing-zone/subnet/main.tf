resource "azurerm_subnet" "private_subnet" {
  count                 = length(var.private_subnet_cidrs)
  name                  = element(var.private_subnet_names, count.index)
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.virtual_network_name
  address_prefixes      = [element(var.private_subnet_cidrs, count.index)]
}

resource "azurerm_subnet" "public_subnet" {
  count                 = length(var.public_subnet_cidrs)
  name                  = element(var.public_subnet_names, count.index)
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.virtual_network_name
  address_prefixes      = [element(var.public_subnet_cidrs, count.index)]
}
