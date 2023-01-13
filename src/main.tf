locals {
  max_length           = 24
  storage_account_name = substr(replace(var.md_metadata.name_prefix, "/[^a-z0-9]/", ""), 0, local.max_length)
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.azure_virtual_network.specs.azure.region
  tags     = var.md_metadata.default_tags
}

resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  account_replication_type = var.redundancy.data_protection ? var.redundancy.replication_type : "LRS"
  min_tls_version          = "TLS1_2"
  # this can be changed without forcing a recreate
  # and can potentially be changed later when
  # we try to push this into a completely private network
  public_network_access_enabled     = true
  infrastructure_encryption_enabled = true
  tags                              = var.md_metadata.default_tags

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
