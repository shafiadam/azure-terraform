////////////////////Resource Group////////////////////

resource_group_name = "rg-network-main-eastus"
location            = "eastus 2"

////////////////Recovery Services Vault////////////////

recovery_service_vault_name = "recovery-vault-hub"

////////////////////Key Vault//////////////////////////
key_vault_name = "kv-hub-prod-01"
# tenant_id      = "5a9720f4-6b29-484c-9c08-17236e613f4d"

////////////////////Log Analytics Workspace////////////
workspace_name = "log-analytics-hub"

////////////////////Virtual Network Configuration/////
ddos_protection_plan_name = "ddos-protection-hub"
vnet_name                 = "vnet-hub-eastus"
vnet_address_space        = "10.0.0.0/16"
subnet_address_spaces     = "10.0.1.0/24"
subnet_names              = "snet-gateway"
nsg_name                  = "nsg-hub"
ip_name                   = "pip-hub"
application_gateway_name  = "agw-hub"
firewall_name             = "fw-hub"
firewall_subnet           = "AzureFirewallSubnet"
firewall_ip               = "pip-fw-hub"
bastionsubnetname         = "AzureBastionSubnet"
bastion_address_prefixes  = ["10.0.5.0/24"]
bastionhostname           = "bastion-hub"
bastion_ip                = "pip-bastion-hub"
JumpBoxname               = "vm-jumpbox-hub"
jumpbox_subnet            = ["10.0.6.0/24"]
firewall_sku_name         = "AZFW_VNet"
firewall_network_rule     = "fw-rule-allow-hub-spoke"
main_vpn_gateway_pip      = "pip-vpn-gateway-hub"
Gateway_subnet_name       = "GatewaySubnet"
Gateway_subnet_prefix     = ["10.0.255.224/27"]
Gateway_name              = "vpn-gateway-hub"
Gateway_type              = "Vpn"
Gateway_vpn_type          = "RouteBased"

////////////////////Storage Account///////////////////
str_name              = "stghub001"
str_account_tier      = "Standard"
str_replication_type  = "LRS"
str_container_name    = "container-sites"
container_access_type = "container"

////////////////////JumpBox VM////////////////////////
jumpBox_os_disk_name   = "osdisk-jumpbox-hub"
jumpBox_size           = "Standard_DS12_v2"
vm_jumpBox_name        = "vm-jumpbox-hub"
jumpBox_computer_name  = "jumpbox-hub"
jumpBox_admin_username = "admin-jumpbox"
jumpBox_password       = "JumpBox@236"

////////////////////NAT Gateway///////////////////////
main_nat_gateway_rg_name   = "rg-nat-gateway-hub"
nat_gateway_public_ip_name = "pip-nat-gateway-hub"
main_nat_gateway_name      = "nat-gateway-hub"

////////////////////Route Table and Route/////////////
route_table_name     = "route-table-hub"
custom_route_name    = "custom-route-hub"
