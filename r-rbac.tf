resource "azurerm_role_assignment" "main" {
  for_each = var.rbac_assignment_enabled ? azurerm_logic_app_workflow.main : {}

  scope                = local.automation_account_id
  principal_id         = each.value.identity[0].principal_id
  role_definition_name = "Automation Contributor"
}
