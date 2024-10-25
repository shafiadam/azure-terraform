////virtual_network_interface-jumbox////

variable "Jumpboxname" {
  type    = string

}
variable "jumpbox_subnet" {
  type = list(string)
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
//// virtual network type ////// 
variable "virtual_network_name"{
  type = string
}