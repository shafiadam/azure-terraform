///////ApplicationGateway///
locals {
  http_setting_name              = "${var.virtual_network_name}-be-htst"
  listener_name                  = "${var.virtual_network_name}-httplstn"
  request_routing_rule_name      = "${var.virtual_network_name}-rqrt"
  redirect_configuration_name    = "${var.virtual_network_name}-rdrcfg"
  backend_address_pool_name      = "${var.virtual_network_name}-beap"
  frontend_port_name             = "${var.virtual_network_name}-feport"
  frontend_ip_configuration_name = "${var.virtual_network_name}-feip"
}

resource "azurerm_application_gateway" "network" {
  name                = var.ag_name
  resource_group_name = var.resource_group_name
  location            = var.location

 sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
 
  gateway_ip_configuration {
    name      = "my-gy-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.azurerm_public_ip_frontend_Ip_id

  }


  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

}
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