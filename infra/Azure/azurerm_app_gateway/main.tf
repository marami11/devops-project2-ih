resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "appgw-gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = var.backend_pool_name
    dynamic "backend_addresses" {
      for_each = var.backend_ip_addresses
      content {
        ip_address = backend_addresses.value
      }
    }
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  http_listener {
    name                           = "appgw-http-listener"
    frontend_ip_configuration_name = var.frontend_ip_name
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name          = "appgw-http-listener"
    backend_address_pool_name   = var.backend_pool_name
    backend_http_settings_name  = "appgw-http-settings"
  }

  backend_http_settings {
    name                  = "appgw-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  tags = var.tags
}