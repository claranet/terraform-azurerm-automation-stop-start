output "resource" {
  description = "Azure Stop/Start with Automation resource object."
  value       = one(azurerm_automation_account.main[*])
}

output "id" {
  description = "Azure Stop/Start with Automation ID."
  value       = local.automation_account_id
}

output "name" {
  description = "Azure Stop/Start with Automation name."
  value       = local.automation_account_name
}

output "identity_principal_id" {
  description = "Azure Stop/Start with Automation system identity principal ID."
  value       = try(azurerm_automation_account.main[0].identity[0].principal_id, null)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
