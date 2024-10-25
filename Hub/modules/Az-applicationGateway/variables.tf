////general properties ////

variable "location" {
  type    = string
  default = ""
}

variable "resource_group_name" {
  description = "Name of the resource group ."
  type        = string
  default     = "myresourcegroup"
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
//// virtual network type ////// 
variable "virtual_network_name"{
  type = string
}

//// azurem subnet id /////
variable "subnet_id" {
  type    = string
}
//////////PublicIp/Frontend//
variable "azurerm_public_ip_frontend_Ip_id"{
  type = string
}