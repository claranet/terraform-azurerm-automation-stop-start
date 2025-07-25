resource "azurerm_automation_runbook" "main" {
  name     = local.runbook_name
  location = var.location

  resource_group_name = var.resource_group_name

  automation_account_name = local.name

  log_verbose  = "true"
  log_progress = "true"
  description  = "Runbook for scheduling Azure resources start and stop."
  runbook_type = "PowerShell"

  content = data.local_file.main.content

  tags = merge(local.default_tags, var.extra_tags)
}

moved {
  from = azurerm_automation_runbook.start_stop
  to   = azurerm_automation_runbook.main
}
