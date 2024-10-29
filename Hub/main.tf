////////////CreatingResourceGroup////
module "resourceGroup" {
  source   = "./modules/Az-resourceGroup"
  name     = var.resource_group_name
  location = var.location
}

////////////DDOS////
module "ddos" {
  source   = "./modules/Az-ddos"
  resource_group_name       = module.resourceGroup.RG_name
  location                  = module.resourceGroup.location
  ddos_protection_plan_name = var.ddos_protection_plan_name

  depends_on = [
    module.resourceGroup
  ]
}

////////////////CreatingVirtualNetwork///////////////////
module "virtualNetwork" {
  source = "./modules/Az-virtualNetwork"

  resource_group_name       = module.resourceGroup.RG_name
  vnetname                  = var.vnet_name
  location                  = module.resourceGroup.location
  vnet_address_space        = var.vnet_address_space
  ddos_protect_id           = module.ddos.ddos_protect_id

  depends_on = [
    module.resourceGroup,
    module.ddos
  ]
}

# ////////////SubNet////
# module "subnet" {
#   source                 = "./modules/Az-subnet"
#   resource_group_name    = module.resourceGroup.RG_name
#   subnet_address_spaces  = var.subnet_address_spaces
#   subnet_name            = var.subnet_names
#   virtual_network_name   = module.virtualNetwork.virtual_network_name

#   depends_on = [
#     module.resourceGroup,
#     module.virtualNetwork
#   ]
# }

# ////////////frontEnd Ip////
# module "publicIP" {
#   source               = "./modules/Az-publicIP"
#   resource_group_name  = module.resourceGroup.RG_name
#   location             = module.resourceGroup.location
#   ipname               = var.ip_name

#   depends_on = [
#     module.resourceGroup
#   ]
# }

# ////////////CreatingRouteTable////
# module "routeTable" {
#   source               = "./modules/Az-routeTable"
#   resource_group_name  = module.resourceGroup.RG_name
#   location             = module.resourceGroup.location
#   route_table_name     = var.route_table_name
#   custom_route_name    = var.custom_route_name
#   subnet_address_spaces = var.subnet_address_spaces
#   subnet_id            = module.subnet.subnet_id

#   depends_on = [
#     module.resourceGroup,
#     module.subnet
#   ]
# }

# ///////azurerm_nat_gateway/////
# module "natGateway" {
#   source                  = "./modules/Az-natGateway"
#   resource_group_name     = module.resourceGroup.RG_name
#   location                = module.resourceGroup.location
#   main_nat_gateway_rg_name = var.main_nat_gateway_rg_name
#   nat_gateway_public_ip_name = var.nat_gateway_public_ip_name
#   main_nat_gateway_name   = var.main_nat_gateway_name
#   subnet_id               = module.subnet.subnet_id

#   depends_on = [
#     module.resourceGroup,
#     module.subnet,
#   ]
# }

# ///////azurerm_bastion/////
# module "bastion" {
#   source                   = "./modules/Az-bastion"
#   resource_group_name      = module.resourceGroup.RG_name
#   location                 = module.resourceGroup.location
#   virtual_network_name     = module.virtualNetwork.virtual_network_name
#   bastionsubnetname        = var.bastionsubnetname
#   bastion_ip               = var.bastion_ip
#   bastionhostname          = var.bastionhostname
#   bastion_address_prefixes = var.bastion_address_prefixes
#   depends_on = [
#     module.resourceGroup,
#     module.virtualNetwork
#   ]
# }
# ///////jumpBox/////
# module "jumpBox" {
#   source                   = "./modules/Az-jumpBox"
#   resource_group_name      = module.resourceGroup.RG_name
#   location                 = module.resourceGroup.location
#   virtual_network_name     = module.virtualNetwork.virtual_network_name
#   jumpbox_subnet           = var.jumpbox_subnet
#   Jumpboxname              = var.JumpBoxname
#   depends_on = [
#     module.resourceGroup,
#     module.virtualNetwork
#   ]
# }
# ///////virtualNetworkGateway/////
# module "virtualNetworkGateway" {
#   source                   = "./modules/Az-virtualNetworkGateway"
#   resource_group_name      = module.resourceGroup.RG_name
#   location                 = module.resourceGroup.location
#   virtual_network_name     = module.virtualNetwork.virtual_network_name
#   main_vpn_gateway_pip     = var.main_vpn_gateway_pip
#   Gateway_subnet_name      = var.Gateway_subnet_name
#   Gateway_subnet_prefix    = var.Gateway_subnet_prefix
#   Gateway_name             = var.Gateway_name
#   Gateway_type             = var.Gateway_type
#   Gateway_vpn_type         = var.Gateway_vpn_type
#   depends_on = [
#     module.resourceGroup,
#     module.virtualNetwork
#   ]
# }
# ///////ApplicationGateway///
# module "applicationGateway" {
#   source                       = "./modules/Az-applicationGateway"
#   resource_group_name          = module.resourceGroup.RG_name
#   location                     = module.resourceGroup.location
#   virtual_network_name         = module.virtualNetwork.virtual_network_name
#   subnet_id                    = module.subnet.subnet_id
#   azurerm_public_ip_frontend_Ip_id = module.publicIP.azurerm_public_ip_frontend_Ip_id
#   ag_name                      = var.application_gateway_name
#   depends_on = [
#     module.resourceGroup,
#     module.virtualNetwork,
#     module.subnet,
#     module.publicIP
#   ]
# }
# ///////Fire Wall Network///
# module "firewallNetwork" {
#   source                       = "./modules/Az-firewallNetwork"
#   resource_group_name          = module.resourceGroup.RG_name
#   location                     = module.resourceGroup.location
#   virtual_network_name         = module.virtualNetwork.virtual_network_name
#   firewall_subnet              = var.firewall_subnet
#   firewall_ip                  = var.firewall_ip
#   firewall_name                = var.firewall_name
#   firewall_sku_name            = var.firewall_sku_name
#   firewall_network_rule        = var.firewall_network_rule

#   depends_on = [
#     module.resourceGroup,
#     module.virtualNetwork,
#   ]
# }
# ////////////Security Group////
# module "securityGroup" {
#   source              = "./modules/Az-securityGroup"
#   resource_group_name = module.resourceGroup.RG_name
#   location            = module.resourceGroup.location
#   nsgname             = var.nsg_name

#   depends_on = [
#     module.resourceGroup
#   ]
# }
