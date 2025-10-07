# إنشاء SQL Server
resource "azurerm_mssql_server" "sql" {
  name                         = "proj-sql-${random_integer.sql_suffix.result}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_password
  public_network_access_enabled = false

  tags = var.tags
}

# Private Endpoint للـ SQL Server
resource "azurerm_private_endpoint" "sql_pe" {
  name                = "${azurerm_mssql_server.sql.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_mssql_server.sql.name}-psc"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  tags = var.tags
}

# Private DNS Zone
resource "azurerm_private_dns_zone" "sql_privatelink" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_link" {
  name                  = "${azurerm_mssql_server.sql.name}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_privatelink.name
  virtual_network_id    = var.vnet_id

  depends_on = [azurerm_private_endpoint.sql_pe]
}