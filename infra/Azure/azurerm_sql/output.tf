# فقط في main.tf
output "sql_server_name" {
  description = "SQL Server name"
  value       = azurerm_mssql_server.sql.name
}

output "sql_database_name" {
  description = "SQL Database name"
  value       = azurerm_mssql_database.db.name
}

output "backend_subnet_vnet_rule" {
  description = "Backend subnet VNet Rule ID"
  value       = azurerm_mssql_virtual_network_rule.backend_vnet_rule.id
}