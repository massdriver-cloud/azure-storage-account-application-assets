locals {
  automated_alarms = {
    success_e2e_latency_metric_alert = {
      severity    = "1"
      frequency   = "PT1M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 500
    }
    success_server_latency_metric_alert = {
      severity    = "1"
      frequency   = "PT1M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 500
    }
  }
  alarms_map = {
    "AUTOMATED" = local.automated_alarms
    "DISABLED"  = {}
    "CUSTOM"    = lookup(var.monitoring, "alarms", {})
  }
  alarms             = lookup(local.alarms_map, var.monitoring.mode, {})
  monitoring_enabled = var.monitoring.mode != "DISABLED" ? 1 : 0
}

module "alarm_channel" {
  source              = "github.com/massdriver-cloud/terraform-modules//azure-alarm-channel?ref=40d6e54"
  md_metadata         = var.md_metadata
  resource_group_name = azurerm_resource_group.main.name
}

module "success_e2e_latency_metric_alert" {
  count                   = local.monitoring_enabled
  source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
  scopes                  = [azurerm_storage_account.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.success_e2e_latency_metric_alert.severity
  frequency               = local.alarms.success_e2e_latency_metric_alert.frequency
  window_size             = local.alarms.success_e2e_latency_metric_alert.window_size

  depends_on = [
    azurerm_storage_account.main
  ]

  md_metadata  = var.md_metadata
  display_name = "E2E Success Latency"
  message      = "High E2E Success Latency"

  alarm_name       = "${var.md_metadata.name_prefix}-highE2ESuccessLatency"
  operator         = local.alarms.success_e2e_latency_metric_alert.operator
  metric_name      = "SuccessE2ELatency"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  aggregation      = local.alarms.success_e2e_latency_metric_alert.aggregation
  threshold        = local.alarms.success_e2e_latency_metric_alert.threshold
}

module "success_server_latency_metric_alert" {
  count                   = local.monitoring_enabled
  source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
  scopes                  = [azurerm_storage_account.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.success_server_latency_metric_alert.severity
  frequency               = local.alarms.success_server_latency_metric_alert.frequency
  window_size             = local.alarms.success_server_latency_metric_alert.window_size

  depends_on = [
    azurerm_storage_account.main
  ]

  md_metadata  = var.md_metadata
  display_name = "Success Server Latency"
  message      = "High Success Server Latency"

  alarm_name       = "${var.md_metadata.name_prefix}-highSuccessServerLatency"
  operator         = local.alarms.success_server_latency_metric_alert.operator
  metric_name      = "SuccessServerLatency"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  aggregation      = local.alarms.success_server_latency_metric_alert.aggregation
  threshold        = local.alarms.success_server_latency_metric_alert.threshold
}
