locals {
  automated_alarms = {
    availability_metric_alert = {
      severity    = "1"
      frequency   = "PT5M"
      window_size = "PT5M"
      operator    = "LessThan"
      aggregation = "Average"
      threshold   = 90
    }
    success_e2e_latency_metric_alert = {
      severity    = "1"
      frequency   = "PT5M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 1000
    }
    success_server_latency_metric_alert = {
      severity    = "1"
      frequency   = "PT5M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 1000
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
  source              = "github.com/massdriver-cloud/terraform-modules//azure/alarm-channel?ref=b4b3190"
  md_metadata         = var.md_metadata
  resource_group_name = azurerm_resource_group.main.name
}

module "availability_metric_alert" {
  count                   = local.monitoring_enabled
  source                  = "github.com/massdriver-cloud/terraform-modules//azure/monitor-metrics-alarm?ref=b4b3190"
  scopes                  = [module.azure_storage_account.account_id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.availability_metric_alert.severity
  frequency               = local.alarms.availability_metric_alert.frequency
  window_size             = local.alarms.availability_metric_alert.window_size

  depends_on = [
    module.azure_storage_account
  ]

  md_metadata  = var.md_metadata
  display_name = "Availability"
  message      = "Low availability"

  alarm_name       = "${var.md_metadata.name_prefix}-lowAvailability"
  operator         = local.alarms.availability_metric_alert.operator
  metric_name      = "Availability"
  metric_namespace = "Microsoft.Storage/storageAccounts"
  aggregation      = local.alarms.availability_metric_alert.aggregation
  threshold        = local.alarms.availability_metric_alert.threshold
}

module "success_e2e_latency_metric_alert" {
  count                   = local.monitoring_enabled
  source                  = "github.com/massdriver-cloud/terraform-modules//azure/monitor-metrics-alarm?ref=b4b3190"
  scopes                  = [module.azure_storage_account.account_id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.success_e2e_latency_metric_alert.severity
  frequency               = local.alarms.success_e2e_latency_metric_alert.frequency
  window_size             = local.alarms.success_e2e_latency_metric_alert.window_size

  depends_on = [
    module.azure_storage_account
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
  source                  = "github.com/massdriver-cloud/terraform-modules//azure/monitor-metrics-alarm?ref=b4b3190"
  scopes                  = [module.azure_storage_account.account_id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.success_server_latency_metric_alert.severity
  frequency               = local.alarms.success_server_latency_metric_alert.frequency
  window_size             = local.alarms.success_server_latency_metric_alert.window_size

  depends_on = [
    module.azure_storage_account
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
