data "local_file" "start_stop" {
  filename = "${path.module}/files/start-stop-resource.ps1"
}

resource "azurerm_automation_runbook" "start_stop" {
  name                    = local.runbook_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = local.automation_account_name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Runbook for scheduling Azure resources start and stop."
  runbook_type            = "PowerShell"

  content = data.local_file.start_stop.content

}
