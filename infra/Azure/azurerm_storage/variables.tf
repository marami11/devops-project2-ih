variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
variable "environment" {
  description = "Deployment environment name, e.g., dev, prod"
  type        = string
  default     = "dev"
}
