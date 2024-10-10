variable "project_id" {
  description = "The ID of the project in which to create the bucket"
  type        = string
  default     = "macro-creek-438019-u1"
}

variable "bucket_name" {
  description = "The name of the bucket to create"
  type        = string
  default     = "yucybweuyf"
}

variable "location" {
  description = "The location where the bucket must be created"
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  type        = string
  default     = "STANDARD"
}
variable "public_access_prevention" {
  description = "Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention. only if the bucket is subject to the public access prevention organization policy constraint. "
  type        = string
  default     = "inherited"
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class
  public_access_prevention = var.public_access_prevention
}
