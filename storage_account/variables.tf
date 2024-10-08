# variables.tf
variable "name" {
  type        = string
  description = "Name of the storage account"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group"
}

variable "account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
  type        = string
}

variable "account_tier" {
  description = "Standard or Premium"
  default     = "Standard"
  type        = string
}

variable "account_replication_type" {
  description = "Redundancy options"
  default     = "LRS"
  type        = string
}

variable "access_tier" {
  type        = string
  description = "Access tier of the storage account (e.g., 'Hot')"
}

variable "minimum_tls_version" {
  description = "The minimum supported TLS version for the storage account"
  default     = "TLS1_2"
  type        = string
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Whether to enable HTTPS traffic only for the storage account"
}

variable "public_access" {
  type        = string
  description = "storage account public access"
  
}
variable "encryption_type" {
  type        = string
  description = "Encryption type for the storage account (e.g., 'MicrosoftManaged')"
}

variable "sku_name" {
  type        = string
  description = "SKU of the RG"
}
//newlistforariables
variable "private_endpoint_name" {
  type        = string
  description = "SKU of the RG"
}
variable "subnet_id" {
  type        = string
  description = "SKU of the RG"
}
variable "virtual_network_id" {
  type        = string
  description = "SKU of the RG"
}