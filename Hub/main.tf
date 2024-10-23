////////////CreatingResourceGroup////
module "resourceGroup" {
  source   = "./modules/Az-resourceGroup"
  name     = var.resource_group_name
  location = var.location
}

////////////////CreatingVirtualNetwork///////////////////
module "virtualNetwork" {
  source = "./modules/Az-virtualNetwork"

  resource_group_name       = module.resourceGroup.RG_name
  ddos_protection_plan_name = var.ddos_protection_plan_name
  vnetname                  = var.vnet_name
  location                  = module.resourceGroup.location
  vnet_address_space        = var.vnet_address_space
  subnet_address_spaces     = var.subnet_address_spaces
  subnet_name             = var.subnet_names
  nsgname                   = var.nsg_name
  ipname                    = var.ip_name
  ag_name                   = var.application_gateway_name
  firewall_subnet           = var.firewall_subnet
  firewall_ip               = var.firewall_ip
  bastionsubnetname         = var.bastionsubnetname
  bastion_ip                = var.bastion_ip
  bastionhostname           = var.bastionhostname
  bastion_address_prefixes  = var.bastion_address_prefixes
  Jumpboxname               = var.JumpBoxname
  firewall_name         = var.firewall_name
  firewall_sku_name     = var.firewall_sku_name
  firewall_network_rule = var.firewall_network_rule
  main_vpn_gateway_pip   = var.main_vpn_gateway_pip
  Gateway_subnet_name   = var.Gateway_subnet_name
  Gateway_subnet_prefix = var.Gateway_subnet_prefix
  Gateway_name          = var.Gateway_name
  Gateway_type          = var.Gateway_type
  Gateway_vpn_type      = var.Gateway_vpn_type
  jumpbox_subnet        = var.jumpbox_subnet
  depends_on = [
    module.resourceGroup
  ]
  main_nat_gateway_rg_name   = var.main_nat_gateway_rg_name
  nat_gateway_public_ip_name = var.nat_gateway_public_ip_name
  main_nat_gateway_name      = var.main_nat_gateway_name
  route_table_name   = var.route_table_name
  custom_route_name  = var.custom_route_name
}

