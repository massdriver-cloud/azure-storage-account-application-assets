locals {
  scope_config = {
    severity    = "1"
    frequency   = "PT1M"
    window_size = "PT5M"
  }
  metric_config = {
    operator_latency  = "GreaterThan"
    aggregation       = "Average"
    threshold_latency = 500
  }
}

module "alarm_channel" {
  source              = "github.com/massdriver-cloud/terraform-modules//azure-alarm-channel?ref=40d6e54"
  md_metadata         = var.md_metadata
  resource_group_name = azurerm_resource_group.main.name
}

module "availability_metric_alert" {
  source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
  scopes                  = [azurerm_storage_account.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.scope_config.severity
  frequency               = local.scope_config.frequency
  window_size             = local.scope_config.window_size

  depends_on = [
    azurerm_storage_account.main
  ]

  md_metadata  = var.md_metadata
  display_name = "Availability"
  message      = "Low availability"

  alarm_name       = "${var.md_metadata.name_prefix}-lowAvailability"
  operator         = "LessThan"
  metric_name      = "Availability"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  aggregation      = local.metric_config.aggregation
  threshold        = 95
}

module "success_e2e_latency_metric_alert" {
  source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
  scopes                  = [azurerm_storage_account.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.scope_config.severity
  frequency               = local.scope_config.frequency
  window_size             = local.scope_config.window_size

  depends_on = [
    azurerm_storage_account.main
  ]

  md_metadata  = var.md_metadata
  display_name = "E2E Success Latency"
  message      = "High E2E Success Latency"

  alarm_name       = "${var.md_metadata.name_prefix}-highE2ESuccessLatency"
  operator         = local.metric_config.operator_latency
  metric_name      = "SuccessE2ELatency"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  aggregation      = local.metric_config.aggregation
  threshold        = local.metric_config.threshold_latency
}

module "success_server_latency_metric_alert" {
  source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
  scopes                  = [azurerm_storage_account.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.scope_config.severity
  frequency               = local.scope_config.frequency
  window_size             = local.scope_config.window_size

  depends_on = [
    azurerm_storage_account.main
  ]

  md_metadata  = var.md_metadata
  display_name = "Success Server Latency"
  message      = "High Success Server Latency"

  alarm_name       = "${var.md_metadata.name_prefix}-highSuccessServerLatency"
  operator         = local.metric_config.operator_latency
  metric_name      = "SuccessServerLatency"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  aggregation      = local.metric_config.aggregation
  threshold        = local.metric_config.threshold_latency
}
