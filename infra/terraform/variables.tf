variable "sql_admin_user" {
  type        = string
  description = "SQL admin username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL admin password"
  sensitive   = true
}

variable "sql_db_name" {
  type        = string
  description = "SQL database name"
}

variable "be_image_name" {
  type        = string
  description = "Backend Docker image name"
  default = "marami11/backend-app"
}

variable "fe_image_name" {
  type        = string
  description = "Frontend Docker image name"
  default = "marami11/frontend-app"
}