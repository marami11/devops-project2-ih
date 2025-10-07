output "nsg_database_id" {
  value = azurerm_network_security_group.database.id
}

output "nsg_backend_id" {
  value = azurerm_network_security_group.backend.id
}

output "nsg_frontend_id" {
  value = azurerm_network_security_group.frontend.id
}