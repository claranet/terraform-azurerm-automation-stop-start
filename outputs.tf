output "resource" {
  description = "Azure Stop/Start with Automation resource object."
  value       = one(azurerm_automation_account.main[*])
}

output "module_diagnostics" {
  description = "Diagnostic settings module outputs."
  value       = module.diagnostics
}

output "id" {
  description = "Azure Stop/Start Automation ID."
  value       = local.automation_account_id
}

output "name" {
  description = "Azure Stop/Start Automation name."
  value       = local.name
}

output "identity_principal_id" {
  description = "Azure Stop/Start Automation identity principal ID."
  value       = try(azurerm_automation_account.main[0].identity[0].principal_id, null)
}
