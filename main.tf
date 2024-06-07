terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.34.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  name                = "vnet-${var.prefix}"
  address_space       = var.vnetAdressSpace
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.prefix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "vnet-diagnostics" {
  name                       = "vnet-diagnostics"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  # log {
  #   category = "allLogs" 

  #   retention_policy {
  #     enabled = false
  #   }
  # }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}

# resource "azurerm_key_vault" "kv" {
#   name                      = "kv-${var.prefix}349787"
#   location                  = var.location
#   resource_group_name       = azurerm_resource_group.rg.name
#   sku_name                  = "standard"
#   tenant_id                 = data.azurerm_client_config.current.tenant_id
#   enable_rbac_authorization = true
# }

# resource "azurerm_monitor_diagnostic_setting" "kv-diagnostics" {
#   name                       = "kv-diagnostics"
#   target_resource_id         = azurerm_key_vault.kv.id
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

#   log {
#     category = "AuditEvent"

#     retention_policy {
#       enabled = false
#     }
#   }

#   metric {
#     category = "AllMetrics"

#     retention_policy {
#       enabled = false
#     }
#   }
# }