############################
# Database NSG
############################
resource "azurerm_network_security_group" "database" {
  name                = "nsg-database-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = var.database_subnet_id
  network_security_group_id = azurerm_network_security_group.database.id
}

resource "azurerm_network_security_rule" "database_allow_webapp" {
  name                        = "AllowWebAppToDB"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = var.backend_subnet_prefix # الباك يقدر يتصل بالداتابيس
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.database.name
}

############################
# Backend NSG
############################
resource "azurerm_network_security_group" "backend" {
  name                = "nsg-backend-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "backend" {
  subnet_id                 = var.backend_subnet_id
  network_security_group_id = azurerm_network_security_group.backend.id
}

# يسمح فقط للـ Frontend أو الـ App Gateway
resource "azurerm_network_security_rule" "backend_allow_frontend" {
  name                        = "AllowFrontendToBackend"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = var.frontend_subnet_prefix
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.backend.name
}

############################
# Frontend NSG
############################
resource "azurerm_network_security_group" "frontend" {
  name                = "nsg-frontend-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "frontend" {
  subnet_id                 = var.frontend_subnet_id
  network_security_group_id = azurerm_network_security_group.frontend.id
}

# يسمح فقط للـ App Gateway
resource "azurerm_network_security_rule" "frontend_allow_appgw" {
  name                        = "AllowAppGatewayToFrontend"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = var.appgw_subnet_prefix
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.frontend.name
}