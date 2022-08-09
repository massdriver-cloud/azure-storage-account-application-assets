# locals {
#   data_infrastructure = {
#     ari = azurerm_storage_account.main.id
#   }
#   data_authentication = {
#     endpoint          = azurerm_storage_account.main.primary_blob_endpoint
#     connection_string = azurerm_storage_account.main.primary_connection_string
#   }
# }

# resource "massdriver_artifact" "authentication" {
#   field                = ""
#   provider_resource_id = azurerm_storage_account.main.id
#   name                 = "Azure Storage Account ${var.md_metadata.name_prefix} (${azurerm_storage_account.main.id})"
#   artifact = jsonencode(
#     {
#       data = {
#         infrastructure = local.data_infrastructure
#         authentication = local.data_authentication
#       }
#       specs = {
#         azure = {
#           region = azurerm_storage_account.main.location
#         }
#       }
#     }
#   )
# }
