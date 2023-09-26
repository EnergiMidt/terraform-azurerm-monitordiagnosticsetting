locals {
  combined_system_name = "${var.system_short_name}-${var.app_name}"
}

locals {
  log_analytics_workspace_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${local.combined_system_name}-${var.environment}-rg/providers/Microsoft.OperationalInsights/workspaces/${local.combined_system_name}-${var.environment}-log"
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                           = "${local.combined_system_name}-diagnostic-setting"
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = local.log_analytics_workspace_resource_id
  log_analytics_destination_type = "Dedicated"

  # WARNING!!!
  # Diagnostic setting does not support mix of log category and log category group.
  # Not all resources have category groups available.
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting

  dynamic "enabled_log" {
    for_each = var.log_category_types
    content {
      category = enabled_log.value

      # TODO: The `retention_policy` has been deprecated in favor of `azurerm_storage_management_policy` resource.
      # Learn more information on the deprecation [in the Azure documentation](https://aka.ms/diagnostic_settings_log_retention).
      # https://github.com/hashicorp/terraform-provider-azurerm/pull/23260
      # https://github.com/hashicorp/terraform-provider-azurerm/issues/23051
      retention_policy {
        enabled = true
      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics

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
