///////azurerm_route/////

variable "route_table_name" {
  type    = string
}

variable "custom_route_name" {
  type    = string
}

variable "subnet_id" {
  type    = string
}
variable "subnet_address_spaces" {
  type = string
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
