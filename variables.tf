variable "name" {
    type = string
    description = "The name of the diagnostic setting"
}

variable "enable" {
    type = bool
    description = "Setting to enable or disable diagnostics."
}

variable "target_resource_id" {
    type = string
    description = "The resource id of the resource to add diagnostic settings to."
}

variable "log_analytics_workspace_id" {
    type = string
    description = "The workspace id of the log analytics workspace to send logs to."
}

variable "diagnostic_logs" {
    type = list(object({ category = string, enabled = bool, retention_policy = object({ enabled = bool, days = number })}))
    description = "An array of diagnostic logs to configure."
}

variable "diagnostic_metrics" {
    type = list(object({ category = string, enabled = bool, retention_policy = object({ enabled = bool, days = number })}))
    description = "An array of diagnostic metrics to configure."
}
