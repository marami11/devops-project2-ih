terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.26.0"
    }
  }

backend "azurerm" {
    resource_group_name  = "maram-rg"
    storage_account_name = "maram"
    container_name       = "maram"
    key                  = "maram.terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "80646857-9142-494b-90c5-32fea6acbc41"
}