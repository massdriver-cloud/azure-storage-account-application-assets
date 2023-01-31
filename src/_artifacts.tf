locals {
  data_infrastructure = {
    ari = azurerm_storage_account.main.id
  }
  data_authentication = {
    endpoint          = azurerm_storage_account.main.primary_blob_endpoint
    connection_string = azurerm_storage_account.main.primary_connection_string
  }
  data_security = {
    iam = {
      "read" = {
        role  = "Storage Blob Data Reader"
        scope = azurerm_storage_account.main.id
      },
      "read_write" = {
        role  = "Storage Blob Data Contributor"
        scope = azurerm_storage_account.main.id
      }
    }
  }
}

resource "massdriver_artifact" "azure_storage_account" {
  field                = "azure_storage_account"
  provider_resource_id = azurerm_storage_account.main.id
  name                 = "Azure Storage Account ${var.md_metadata.name_prefix} (${azurerm_storage_account.main.id})"
  artifact = jsonencode(
    {
      data = {
        infrastructure = local.data_infrastructure
        authentication = local.data_authentication
        security       = local.data_security
      }
      specs = {
        azure = {
          region = azurerm_storage_account.main.location
        }
      }
    }
  )
}
