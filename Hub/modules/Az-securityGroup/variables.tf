variable "resource_group_name" {
  description = "Name of the resource group ."
  type        = string
  default     = "myresourcegroup"
}
variable "location" {
  type = string
  description = "The geographical region where the resource group will be created."
}
variable "nsgname" {
  description = "Name of the nsg to create"
  type        = string
  default     = ""
}