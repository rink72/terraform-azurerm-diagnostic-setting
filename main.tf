terraform {
  required_version = ">= 0.12.0"
}

# A special variable used to pass in dependencies to the module
variable "ds_depends_on" {
  type        = any
  description = "A special variable used to pass in dependencies to the module"
  default     = null
}

locals {
  # local count variable that determines if diagnostics are deployed or not
  diag_count = var.enable ? 1 : 0
}

resource "azurerm_monitor_diagnostic_setting" "diag_setting" {
  name               = var.name
  target_resource_id = var.target_resource_id
  count = local.diag_count

  # log destinations. Currently, we have only implemented log analytics.
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Define the logs to be stored
  dynamic "log" {
    for_each = var.diagnostic_logs
    content {
      category = log.value.category
      enabled  = log.value.enabled
      retention_policy {
        enabled = log.value.retention_policy.enabled
        days    = log.value.retention_policy.days
      }
    }
  }

  # Define the metrics to be stored
  dynamic "metric" {
    for_each = var.diagnostic_metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_policy.enabled
        days    = metric.value.retention_policy.days
      }
    }
  }

  # Check if there are any dependencies required
  depends_on = [
    var.ds_depends_on
  ]
}
