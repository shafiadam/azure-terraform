
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
variable "subnet_id" {
  type    = string
}
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
