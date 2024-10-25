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

//// virtual network name ////// 
variable "virtual_network_name"{
  type = string
}

