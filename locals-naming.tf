locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name                = var.automation_account != null ? reverse(split("/", var.automation_account.id))[0] : coalesce(var.custom_name, data.azurecaf_name.automation.result)
  runbook_name        = coalesce(var.runbook_custom_name, data.azurecaf_name.runbook.result)
  api_connection_name = coalesce(var.api_connection_custom_name, data.azurecaf_name.api_connection.result)
  workflow_name = {
    for key, value in var.schedules : key => format("%s-%s", coalesce(var.workflow_custom_name, data.azurecaf_name.workflow.result), key)
  }
}
