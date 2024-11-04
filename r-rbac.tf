resource "azurerm_role_assignment" "main" {
  for_each             = var.schedules
  scope                = local.automation_account_id
  role_definition_name = "Automation Contributor"
  principal_id         = azurerm_logic_app_workflow.main[each.key].identity[0].principal_id
}
