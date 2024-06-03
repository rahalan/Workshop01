terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.34.0"
    }
  }
  required_version = "1.8.3"
  backend "azurerm" {
      resource_group_name  = "rg-rahalan" # change to your rg name
      storage_account_name = "tfstate111112" # change to your storage account name
      container_name       = "tfstate" # change to your container name
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name = "rg-rahalan" # change to your rg name
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name = "${var.prefix}-vnet"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = var.vnetAdressSpace
}

resource "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}