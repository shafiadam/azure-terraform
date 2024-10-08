# custom_modules/storage_account/main.tf
resource "azurerm_storage_account" "example" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
   network_rules {
    default_action             = var.public_access
    ip_rules                   = []
  }

  tags = {
    environment = "staging"
    Region  = var.resource_group_location
  }
}

resource "azurerm_private_dns_zone" "pdns_st" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}



resource "azurerm_private_endpoint" "pep_st" {
  
  name                = "pep-sd2488-st-non-prod-weu"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = "/subscriptions/d1478d43-aba4-4d8e-b540-bf2d7578b5fd/resourceGroups/rgsacct/providers/Microsoft.Network/virtualNetworks/vmet1/subnets/default"

  private_service_connection {
    name                           = "sc-sta"
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-group-sta"
    private_dns_zone_ids = [azurerm_private_dns_zone.pdns_st.id]
  }
}
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_lnk_sta" {
  name                  = "lnk-dns-vnet-sta"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pdns_st.name
  virtual_network_id    = "/subscriptions/d1478d43-aba4-4d8e-b540-bf2d7578b5fd/resourceGroups/rgsacct/providers/Microsoft.Network/virtualNetworks/vmet1"
  }

resource "azurerm_private_dns_a_record" "dns_a_sta" {
  name                = "sta_a_record"
  zone_name           = azurerm_private_dns_zone.pdns_st.name 
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pep_st.private_service_connection.0.private_ip_address]
}
