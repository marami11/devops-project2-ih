variable "environment" {
  description = "Deployment environment name (e.g., dev, prod)"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "database_subnet_id" {
  description = "Database subnet ID"
  type        = string
}

variable "backend_subnet_id" {
  description = "Backend subnet ID"
  type        = string
}

variable "frontend_subnet_id" {
  description = "Frontend subnet ID"
  type        = string
}

variable "frontend_subnet_prefix" {
  description = "Frontend subnet CIDR"
  type        = string
}

variable "backend_subnet_prefix" {
  description = "Backend subnet CIDR"
  type        = string
}

variable "appgw_subnet_prefix" {
  description = "App Gateway subnet CIDR"
  type        = string
}