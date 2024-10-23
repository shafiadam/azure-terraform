

//------------------------General Properties------------------------------------------//


variable "vnetname" {
  description = "Name of the vnet to create"
  type        = string
  default     = "my-network"
}

variable "resource_group_name" {
  description = "Name of the resource group ."
  type        = string
  default     = "myresourcegroup"
}

variable "ddos_protection_plan_name" {

}
variable "vnet_address_space" {
  type        = string
  description = "The address space that is used by the virtual network."
  default     = ""
}

variable "location" {
  type    = string
  default = ""
}
variable "subnet_name" {
  type = string
}

variable "subnet_address_spaces" {
  type = string
}
variable "nsgname" {
  description = "Name of the nsg to create"
  type        = string
  default     = ""
}
variable "ipname" {
  description = "Name of the publicip"
  type        = string
  default     = ""
}

variable "dns_server" {
  type    = string
  default = "10.0.0.4"
}

////firewall////

variable "firewall_name" {
  type    = string
}
variable "firewall_subnet" {
  type    = string
}
variable "firewall_ip" {
  type    = string
}
variable "firewall_sku_name" {
  type    = string
}
variable "firewall_network_rule" {
  type    = string
}
variable "Gateway_subnet_name" {
  type    = string
}
variable "Gateway_subnet_prefix" {
  type = list(string)
}
variable "Gateway_name" {
  type        = string
}
variable "main_vpn_gateway_pip" {
  type = string
}
variable "Gateway_type" {
  type        = string
}
variable "Gateway_vpn_type" {
  type        = string
}

////gw////
variable "ag_name" {
  type = string
}


variable "sku" {
  default = "Standard_Small"
}

variable "tier" {
  default = "Standard"
}

////bastion////
variable "bastionsubnetname" {
   type = string
}
variable "bastionhostname" {
  type = string
}
variable "bastion_ip" {
  type = string
}
variable "bastion_address_prefixes" {
  type = list(string)
}

////virtual_network_interface-jumbox////

variable "Jumpboxname" {
  type    = string

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

//------------------------TAGS-------------------------\\
variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    "Service"     = "main"
    "Environment" = "Development"
    
  }
}





