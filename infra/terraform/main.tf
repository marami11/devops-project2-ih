# ========================================
# Module: Resource Group
# ========================================
module "resource_group" {
  source   = "../Azure/azurerm_resource_group"
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

# ========================================
# Module: Virtual Network
# ========================================
module "vnet" {
  source              = "../Azure/azurerm_virtual_network"
  name                = local.vnet_name
  resource_group_name = module.resource_group.resource_group.name
  location            = local.location
  address_space       = local.address_space
  tags                = local.tags
}

# ========================================
# Module: Subnets
# ========================================
module "subnets" {
  source              = "../Azure/azurerm_subnets"
  for_each            = local.subnet
  name                = each.key
  resource_group_name = module.resource_group.resource_group.name
  vnet_name           = module.vnet.virtual_network.name
  address_prefixes    = each.value.address_space

  delegation = (
    contains(["frontend_subnet", "backend_subnet"], each.key)
    ? {
        name = "${each.key}-delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    : null
  )
}


# ========================================
# Module: Database
# ========================================
module "sql" {
  source = "../Azure/azurerm_sql"

  environment        = "dev"
  resource_group_name = module.resource_group.resource_group.name
  location           = local.location
  vnet_id            = module.vnet.virtual_network.id
  subnet_id          = module.subnets["database_subnet"].subnet.id
  sql_admin_user     = var.sql_admin_user
  sql_admin_password = var.sql_admin_password
  sql_db_name        = var.sql_db_name
  sql_sku            = "S0"
  tags               = local.tags

  depends_on = [module.subnets]
}
module "nsg" {
  source              = "../Azure/azurerm_nsg"
  environment         = "dev"
  location            = local.location
  resource_group_name = module.resource_group.resource_group.name
  database_subnet_id  = module.subnets["database_subnet"].subnet.id
  backend_subnet_id   = module.subnets["backend_subnet"].subnet.id
  frontend_subnet_id  = module.subnets["frontend_subnet"].subnet.id
  frontend_subnet_prefix = "10.0.2.0/24"
  backend_subnet_prefix  = "10.0.3.0/24"
  appgw_subnet_prefix    = "10.0.1.0/24"
  tags                = local.tags
}

module "storage" {
  source = "../Azure/azurerm_storage"

  resource_group_name = module.resource_group.resource_group.name
  location            = local.location
  tags                = local.tags

  depends_on = [module.resource_group]
}
module "webapp" {
  source              = "../Azure/azurerm_apps"
  resource_group_name = module.resource_group.resource_group.name
  location            = local.location

  # Frontend
  service_plan_name_fe = "plan-web1"
  fe_app_name          = "project-web1-maram"
  fe_image_name      = var.fe_image_name
  fe_tag               = "latest"
  fe_sku               = "P1v2"
  public_access        = true

  # Backend
  service_plan_name_be = "plan-web2"
  be_app_name          = "project2-web2-maram"
  be_image_name      = var.be_image_name
  be_tag               = "latest"
  be_sku               = "P1v2"

  sql_admin_password = "P@ssword123!"

  frontend_subnet_id = module.subnets["frontend_subnet"].subnet.id
  backend_subnet_id  = module.subnets["backend_subnet"].subnet.id
}
module "app_gateway" {
  source              = "../Azure/azurerm_app_gateway"
  resource_group_name = module.resource_group.resource_group.name
  location            = local.location
  subnet_id           = module.subnets["gateway_subnet"].subnet.id
  backend_ip_addresses = [
    # IPs of your backend web apps if static, أو NIC IDs
  ]
  tags = local.common_tags
}