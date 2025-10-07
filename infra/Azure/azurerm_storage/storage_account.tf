resource "azurerm_storage_account" "storage" {
   name                     = "${var.environment}stor${substr(md5(var.environment),0,8)}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  #allow_blob_public_access  = false

  tags = var.tags

  lifecycle {
    prevent_destroy = false
  }
}