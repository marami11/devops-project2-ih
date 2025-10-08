variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the App Gateway"
  type        = string
}

variable "frontend_ip_name" {
  description = "Frontend IP configuration name"
  type        = string
  default     = "appgw-frontend-ip"
}

variable "gateway_name" {
  description = "App Gateway name"
  type        = string
  default     = "app-gateway"
}

variable "backend_pool_name" {
  description = "Backend pool name"
  type        = string
  default     = "appgw-backend-pool"
}

variable "backend_ip_addresses" {
  description = "Backend IP addresses or NIC IDs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
  default     = {}
}