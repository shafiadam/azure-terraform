variable "name" {
  type = string
  description = "The name of the resource group to be created."
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    "Service"     = "Main Application"
    "Environment" = "Development"
  }
}

variable "location" {
  type = string
  description = "The geographical region where the resource group will be created."
}