output "app_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.appgw.id
}

output "app_gateway_frontend_ip" {
  description = "The frontend public IP of the App Gateway"
  value       = azurerm_public_ip.appgw_pip.ip_address
}