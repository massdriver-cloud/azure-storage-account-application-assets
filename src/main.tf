locals {
  max_length = 24
  # Storage account names allow letters and numbers only, no special characters. Also limits to a max length or 24 characters.
  storage_account_name = substr(join("", split("-", var.md_metadata.name_prefix)), 0, local.max_length)
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.storage.region
}

resource "azurerm_storage_account" "main" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  account_tier             = "Standard"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  account_replication_type = var.redundancy.replication_type

  identity {
    type = "SystemAssigned"
  }

  blob_properties {
    dynamic "delete_retention_policy" {
      for_each = var.redundancy.data_protection ? [1] : []
      content {
        days = var.redundancy.data_protection_days
      }
    }
    dynamic "container_delete_retention_policy" {
      for_each = var.redundancy.data_protection ? [1] : []
      content {
        days = var.redundancy.data_protection_days
      }
    }
  }
}
