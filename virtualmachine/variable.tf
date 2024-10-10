variable "client_secret" {
  type = string
  sensitive = true
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "test"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
variable "admin_username" {
  type        = string
  description = "The administrator username of the SQL logical server."
  default     = "azureadmin"
}
variable "admin_password" {
  type        = string
  description = "The administrator password of the SQL logical server."
  sensitive   = true
  default     = "Reddeadredemption2"
}

# variable "sql_db_name" {
#   type        = string
#   description = "The name of the SQL Database."
#   default     = "SampleDB"
# }