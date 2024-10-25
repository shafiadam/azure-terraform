

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

variable "vnet_address_space" {
  type        = string
  description = "The address space that is used by the virtual network."
  default     = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "dns_server" {
  type    = string
  default = "10.0.0.4"
}

variable "ddos_protect_id" {
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





