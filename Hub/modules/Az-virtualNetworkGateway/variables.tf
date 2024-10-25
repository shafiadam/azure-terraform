//// virtual network type ////// 
variable "virtual_network_name"{
  type = string
}
/////////gateway////////
variable "main_vpn_gateway_pip" {
  type = string
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
variable "Gateway_type" {
  type        = string
}

variable "Gateway_vpn_type" {
  type        = string
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
