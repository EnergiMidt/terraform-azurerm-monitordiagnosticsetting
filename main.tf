locals {
  combined_system_name = "${var.system_short_name}-${var.app_name}"
}

locals {
  log_analytics_workspace_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${local.combined_system_name}-${var.environment}-rg/providers/Microsoft.OperationalInsights/workspaces/${local.combined_system_name}-${var.environment}-log"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                           = "${local.combined_system_name}-diagnostic-setting"
  target_resource_id             = var.diagnostic_target_resource_id
  log_analytics_workspace_id     = local.log_analytics_workspace_resource_id
  log_analytics_destination_type = "Dedicated"

  dynamic "enabled_log" {
    for_each = var.diagnostic_categories_log_category_groups
    content {
      category_group = enabled_log.value

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_categories_metrics

    content {
      category = metric.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 30
      }
    }
  }
}
