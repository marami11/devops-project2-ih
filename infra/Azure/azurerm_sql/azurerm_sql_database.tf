resource "random_integer" "sql_suffix" {
  min = 1000
  max = 9999
}

# إنشاء قاعدة البيانات داخل SQL Server
resource "azurerm_mssql_database" "db" {
  name       = var.sql_db_name
  server_id  = azurerm_mssql_server.sql.id
  sku_name   = var.sql_sku
  max_size_gb = 5

  tags = var.tags
}