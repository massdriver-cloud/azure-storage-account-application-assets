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
  name                              = local.storage_account_name
  resource_group_name               = azurerm_resource_group.main.name
  location                          = azurerm_resource_group.main.location
  account_tier                      = "Standard"
  account_kind                      = "StorageV2"
  access_tier                       = "Hot"
  account_replication_type          = var.redundancy.replication_type
  min_tls_version                   = "TLS1_2"
  public_network_access_enabled     = false
  infrastructure_encryption_enabled = true
  tags                              = var.md_metadata.default_tags

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    virtual_network_subnet_ids = [var.azure_virtual_network.data.infrastructure.default_subnet_id]
  }

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

resource "azurerm_private_endpoint" "main" {
  name                = var.md_metadata.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = var.azure_virtual_network.data.infrastructure.default_subnet_id

  private_service_connection {
    name                           = "storage"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.main.id
    subresource_names              = ["blob"]
  }
}
