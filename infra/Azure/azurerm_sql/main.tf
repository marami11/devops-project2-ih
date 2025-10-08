resource "random_integer" "sql_suffix" {
  min = 1000
  max = 9999
}

# SQL Server
resource "azurerm_mssql_server" "sql" {
  name                         = "proj-sql-${random_integer.sql_suffix.result}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
  public_network_access_enabled = true  # لازم يكون true للـ VNet Rules

  tags = var.tags
}

# قاعدة البيانات داخل SQL Server
resource "azurerm_mssql_database" "db" {
  name       = var.sql_db_name
  server_id  = azurerm_mssql_server.sql.id
  sku_name   = var.sql_sku
  max_size_gb = 5

  tags = var.tags
}
# Virtual Network Rule للـ backend subnet
resource "azurerm_mssql_virtual_network_rule" "backend_vnet_rule" {
  name                = "AllowBackendSubnet"
  server_id           = azurerm_mssql_server.sql.id
  subnet_id           = var.subnet_id
  ignore_missing_vnet_service_endpoint = false
}