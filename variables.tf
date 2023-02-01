variable "subscription_id" {
  default  = "00000000-0000-0000-0000-000000000000"
  nullable = false
  type     = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "The subscription_id value must be a valid globally unique identifier (GUID)."
  }
}

variable "system_short_name" {
  description = <<EOT
  (Required) Specifies the short abbreviation of the system name according to naming convention guidelines.
  Will be part of the final name of the deployed resource.
  EOT
  type        = string
}

variable "app_name" {
  description = <<EOT
  (Required) Specifies the application name of within the system according to naming convention guidelines.
  Will be part of the final name of the deployed resource.
  EOT
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Possible values are dev, test, and prod."
  }
}

variable "diagnostic_target_resource_id" {
  description = <<EOT
  (Required) The ID of an existing Resource on which to configure Diagnostic Settings.
  Changing this forces a new resource to be created.
  EOT
  type        = string
}

variable "diagnostic_categories_log_category_groups" {
  description = <<EOT
  (Required) The list of Diagnostic Log Category Groups.
  The Log Categories available vary depending on the Resource being used.
  You may wish to use the `azurerm_monitor_diagnostic_categories` Data Source or list of service specific schemas to identify which categories are available for a given Resource.
  EOT
  type        = list(string)
}

variable "diagnostic_categories_metrics" {
  description = <<EOT
  (Optional) The list of Diagnostic Metrics.
  The Metric Categories available vary depending on the Resource being used.
  You may wish to use the `azurerm_monitor_diagnostic_categories` Data Source to identify which categories are available for a given Resource.
  EOT
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
