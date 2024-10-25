variable "subnet_name" {
  type = string
}

variable "resource_group_name" {
  description = "Name of the resource group ."
  type        = string
  default     = "myresourcegroup"
}

variable "subnet_address_spaces" {
  type = string
}

//// virtual network type ////// 
variable "virtual_network_name"{
  type = string
}