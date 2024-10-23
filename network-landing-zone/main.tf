resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = var.ddos_protection_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
}
///virtual-network///
resource "azurerm_virtual_network" "main_virtual_network" {
  name                = var.vnetname
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
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_virtual_network.name
  address_prefixes = [var.subnet_address_spaces]

}
//security group//
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgname
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {   //Here opened remote desktop port
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
resource "azurerm_public_ip" "frontend_Ip" {
  name                = var.ipname
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"



}
///////ApplicationGateway///
locals {
  http_setting_name              = "${azurerm_virtual_network.main_virtual_network.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.main_virtual_network.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.main_virtual_network.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.main_virtual_network.name}-rdrcfg"
  backend_address_pool_name      = "${azurerm_virtual_network.main_virtual_network.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.main_virtual_network.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.main_virtual_network.name}-feip"
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
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.frontend_Ip.id

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
  virtual_network_name = azurerm_virtual_network.main_virtual_network.name
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

//////////////Bastion////////////////
resource "azurerm_subnet" "Bastion_Subnet" {
  name                 = var.bastionsubnetname
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_virtual_network.name
  address_prefixes     = var.bastion_address_prefixes
  depends_on = [
    var.resource_group_name
  ]
}
resource "azurerm_public_ip" "Bastion_Ip" {
  name                = var.bastion_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_bastion_host" "Bastion_Host" {
  name                = var.bastionhostname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "bastion-configuration"
    subnet_id            = azurerm_subnet.Bastion_Subnet.id
    public_ip_address_id = azurerm_public_ip.Bastion_Ip.id
  }
  depends_on = [
    var.resource_group_name
  ]
}

resource "azurerm_public_ip" "main-vpn-gy1-pip" {
  name                = var.main_vpn_gateway_pip
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Dynamic"
}
resource "azurerm_subnet" "main-gy-subnet" {
  name                 = var.Gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_virtual_network.name
  address_prefixes     = var.Gateway_subnet_prefix
  depends_on = [
    var.resource_group_name
  ]
}
resource "azurerm_virtual_network_gateway" "main-vnet-gy" {
  name                = var.Gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.Gateway_type
  vpn_type = var.Gateway_vpn_type

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.main-vpn-gy1-pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.main-gy-subnet.id
  }
}



resource "azurerm_subnet" "JumpBox_Subnet" {
  name                 = "JumpboxSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_virtual_network.name
  address_prefixes     = var.jumpbox_subnet
  depends_on = [
    var.resource_group_name
  ]
}


resource "azurerm_network_interface" "JumpBox" {
  name                = var.Jumpboxname
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "JumpBox-ipconfiguration"
    subnet_id                     = azurerm_subnet.JumpBox_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

///////azurerm_nat_gateway/////

resource "azurerm_public_ip" "main_nat_gateway_public_ip" {
  name                = var.nat_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "main_nat_gateway" {
  name                    = var.main_nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group_name
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gy_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.main_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.main_nat_gateway_public_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.main_nat_gateway.id
}
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
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.route_table.id
}
