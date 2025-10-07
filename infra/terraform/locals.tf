locals {
  resource_group_name = "project2-maram-rg"
  vnet_name           = "project2-vnet"
  location            = "Central US"
  environment         = "dev"

  tags = {
    bootcamp = "project2"
  }

  address_space = ["10.0.0.0/16"]

  subnet = {
    gateway_subnet = {
      address_space = ["10.0.0.0/24"]
    }
    frontend_subnet = {
      address_space = ["10.0.1.0/24"]
    }
    backend_subnet = {
      address_space = ["10.0.2.0/24"]
    }
    database_subnet = {
      address_space = ["10.0.3.0/24"]
    }
  }
  common_tags = {
    Project     = local.resource_group_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Team        = "DevOps"
  }

}