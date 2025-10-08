variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "vnet_id" {
  description = "ID of the Virtual Network"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the backend"
  type        = string
}

variable "sql_admin_user" {
  description = "SQL admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}

variable "sql_db_name" {
  description = "SQL Database name"
  type        = string
}

variable "sql_sku" {
  description = "SQL Database SKU"
  type        = string
  default     = "S0"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}