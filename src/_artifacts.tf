resource "massdriver_artifact" "azure_storage_account_blob" {
  field                = "azure_storage_account_blob"
  provider_resource_id = azurerm_storage_account.main.id
  name                 = "Azure Blob Storage Account ${var.md_metadata.name_prefix} (${azurerm_storage_account.main.id})"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          ari      = azurerm_storage_account.main.id
          endpoint = azurerm_storage_account.main.primary_blob_endpoint
        }
        security = {
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
      specs = {
        azure = {
          region = azurerm_resource_group.main.location
        }
      }
    }
  )
}
