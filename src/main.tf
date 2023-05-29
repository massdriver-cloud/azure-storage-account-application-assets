resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.account.region
  tags     = var.md_metadata.default_tags
}

module "azure_storage_account" {
  source              = "github.com/massdriver-cloud/terraform-modules//azure/storage-account?ref=87cc8c2"
  name                = var.md_metadata.name_prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  kind                = "StorageV2"
  tier                = "Standard"
  access_tier         = "Hot"
  replication_type    = var.redundancy.replication_type
  tags                = var.md_metadata.default_tags

  blob_properties = {
    delete_retention_policy           = var.redundancy.data_protection
    container_delete_retention_policy = var.redundancy.data_protection

    dynamic "cors_rule" {
      for_each = var.cors_rules
      content {
        allowed_headers = cors_rule.value.allowed_headers
        allowed_methods = cors_rule.value.allowed_methods
        allowed_origins = cors_rule.value.allowed_origins
        exposed_headers = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }
  }
}
