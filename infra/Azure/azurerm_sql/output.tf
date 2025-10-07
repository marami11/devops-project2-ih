output "sql_server_name" {
  description = "SQL Server name"
  value       = azurerm_mssql_server.sql.name
}

output "sql_database_name" {
  description = "SQL Database name"
  value       = azurerm_mssql_database.db.name
}

output "sql_private_endpoint_ip" {
  description = "Private IP of SQL Private Endpoint"
  value       = azurerm_private_endpoint.sql_pe.private_service_connection[0].private_ip_address
}