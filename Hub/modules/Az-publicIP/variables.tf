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

variable "ipname" {
  description = "Name of the publicip"
  type        = string
  default     = ""
}
