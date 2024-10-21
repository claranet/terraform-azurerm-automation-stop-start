data "local_file" "start_stop" {
  filename = "${path.module}/files/start-stop-resource.ps1"
}

resource "azurerm_automation_runbook" "start_stop" {
  name                    = local.runbook_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.main.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This is a runbook to stop/start an Azure resource"
  runbook_type            = "PowerShell"

  content = data.local_file.start_stop.content

}
