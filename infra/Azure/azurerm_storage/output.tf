output "storage_account_name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  description = "Storage Account ID"
  value       = azurerm_storage_account.storage.id
}