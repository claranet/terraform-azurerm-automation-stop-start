# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

# Custom naming override
variable "custom_name" {
  description = "Custom Automation account name, generated if not set."
  type        = string
  default     = ""
}

variable "runbook_custom_name" {
  description = "Custom runbook name, generated if not set."
  type        = string
  default     = ""
}

variable "api_connection_custom_name" {
  description = "Custom API connection name, generated if not set."
  type        = string
  default     = ""
}

variable "workflow_custom_name" {
  description = "Custom workflow name, generated if not set."
  type        = string
  default     = ""
}
