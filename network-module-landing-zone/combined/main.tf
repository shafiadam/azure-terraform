resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = var.DDoSPlanName
  resource_group_name = var.resource_group_name
  location            = var.location
}

///virtual-network///
resource "azurerm_virtual_network" "Vnet-HUB" {
  name                = var.NameofVnet
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["${var.vnet_address_space}"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.ddos.id
    enable = true
  }
  tags = var.tags   
}

///Frontend/backend/subnet///
resource "azurerm_subnet" "subnet" {
  name                 = var.SubnetName
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet-HUB.name
  address_prefixes     = [var.subnet_address_spaces]
}

//security group//
resource "azurerm_network_security_group" "nsg" {
  name                = var.NSGName
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "RDP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

//////PublicIp/Frontend//
resource "azurerm_public_ip" "frontendip" {
  name                = var.IPName
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

///////ApplicationGateway///
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.Vnet-HUB.name}-be-pool"
  frontend_port_name             = "${azurerm_virtual_network.Vnet-HUB.name}-fe-portname"
  frontend_ip_configuration_name = "${azurerm_virtual_network.Vnet-HUB.name}-fe-ip"
  http_setting_name              = "${azurerm_virtual_network.Vnet-HUB.name}-be-settings"
  listener_name                  = "${azurerm_virtual_network.Vnet-HUB.name}-listener"
  request_routing_rule_name      = "${azurerm_virtual_network.Vnet-HUB.name}-rqst-route"
  redirect_configuration_name    = "${azurerm_virtual_network.Vnet-HUB.name}-redirect"
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
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.frontendip.id
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

resource "azurerm_subnet" "firewallsubnet" {
  name                 = var.firewall_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet-HUB.name
  address_prefixes     = ["10.0.10.0/24"]
}

resource "azurerm_public_ip" "firewallip" {
  name                = var.firewall_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.FirewallName
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.FirewallSKUName
  sku_tier            = "Standard"
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewallsubnet.id
    public_ip_address_id = azurerm_public_ip.firewallip.id
  }
}

resource "azurerm_firewall_network_rule_collection" "firewallrule" {
  name                = var.FirewallNetworkRule
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Deny"

  rule {
    name = "firewallrule"

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

//////////////Bastion////////////////
resource "azurerm_subnet" "bastionsubnet" {
  name                 = var.BastionSubnetName
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet-HUB.name
  address_prefixes     = var.BastionAddressPrefixes
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_public_ip" "bastionip" {
  name                = var.BastionIP
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_bastion_host" "bastionhost" {
  name                = var.BastionHostname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "bastion-configuration"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastionip.id
  }
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_public_ip" "hub-vpn-gateway1-pip" {
  name                = var.hub_vpn_gateway_pip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = var.Gateway_SubnetName
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet-HUB.name
  address_prefixes     = var.GatewaySubnetPrefix
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_virtual_network_gateway" "hub-vnet-gateway" {
  name                = var.GatewayName
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.Gateway_type
  vpn_type = var.Gateway_vpn_type

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.hub-vpn-gateway1-pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
  }
}

resource "azurerm_subnet" "Jumpbox_subnet" {
  name                 = "JumpboxSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet-HUB.name
  address_prefixes     = var.JumpboxSubnet
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_network_interface" "Jumpbox" {
  name                = var.Jumpboxname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "Jumpbox-ipconfiguration"
    subnet_id                     = azurerm_subnet.Jumpbox_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
