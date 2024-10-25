/////ResourceGroup////
variable "resource_group_name" {

  type = string
}
variable "location" {

  type    = string
  default = ""
}
///////////ddos////////
variable "ddos_protection_plan_name" {
  type    = string
}
///////////workspace_name////////
variable "workspace_name" {
  description = "The name of the log analytics workspace name."
  type        = string
}
////recovery_service_vault////
variable "recovery_service_vault_name" {
  type        = string
}
//////////KeyVault//////////
 variable "key_vault_name" {
   type    = string
   default = ""
 }



variable "tenant_id" {
  type    = string
  default = ""

 }

///////////////storage-account///////////

variable "str_name" {
  description = "The name of the storage account."
  type        = string
}

variable "str_account_tier" {
  description = "The tier to use for this storage account."
  type        = string
}

variable "str_replication_type" {
  description = "The type of replication type to use for this storage account."
  type        = string
}

variable "str_container_name" {
  description = "The type of replication type to use for this storage account."
  type        = string
}

variable "container_access_type" {
  description = "The type of replication type to use for this storage account."
  type        = string
}
//////////////////////////////////JumpHost/////////////////////////
variable "vm_jumpBox_name" {
  type        = string
}

variable "jumpBox_size" {
  type        = string
}
variable "jumpBox_computer_name" {
  type        = string
}
variable "jumpBox_os_disk_name" {
  type        = string
}
variable "jumpBox_admin_username" {
  type        = string
}
variable "jumpBox_password" {
  type        = string
}

/////virtual_network_gateway/////
variable "main_vpn_gateway_pip" {
  type = string
}

variable "Gateway_subnet_name" {
  description = "Name of the virtual wan to create"
  type        = string
}

variable "Gateway_subnet_prefix" {
  type = list(string)
}
variable "Gateway_name" {
  type        = string
}

variable "Gateway_type" {
  type        = string
}
variable "Gateway_vpn_type" {
  type        = string
}

//////////VnetConfig///////////
variable "vnet_address_space" {
  type = string
}

variable "subnet_names" {
  type = string
}

variable "subnet_address_spaces" {
  type = string
}

variable "vnet_name" {
  type    = string
  default = ""
}
variable "nsg_name" {
  type    = string
  default = ""
}
variable "ip_name" {
  type    = string
  default = ""

}
variable "application_gateway_name" {
  type = string
}

//////////firewall///////////
variable "firewall_name" {
  type = string
}
variable "firewall_subnet" {
  type = string
}

variable "firewall_ip" {
  type = string
}

variable "firewall_sku_name" {
  type = string
}
variable "firewall_network_rule" {
  type = string
}


///////bastion/////
variable "bastionsubnetname" {
  type = string
}
variable "bastionhostname" {
  type = string
}


variable "bastion_address_prefixes" {
  type = list(string)
}
variable "bastion_ip" {
  type = string
}
variable "JumpBoxname" {
  type = string
}
variable "jumpbox_subnet" {
  type = list(string)
}

///////azurerm_nat_gateway/////

variable "main_nat_gateway_rg_name" {
  type    = string

}

variable "nat_gateway_public_ip_name" {
  type    = string

}
variable "main_nat_gateway_name" {
  type    = string

}

///////azurerm_route/////

variable "route_table_name" {
  type    = string

}

variable "custom_route_name" {
  type    = string

}



