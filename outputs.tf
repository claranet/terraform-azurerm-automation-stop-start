output "resource" {
  description = "Azure Stop/Start with Automation resource object."
  value       = azurerm_automation_account.main
}

output "id" {
  description = "Azure Stop/Start with Automation ID."
  value       = azurerm_automation_account.main.id
}

output "name" {
  description = "Azure Stop/Start with Automation name."
  value       = azurerm_automation_account.main.name
}

output "identity_principal_id" {
  description = "Azure Stop/Start with Automation system identity principal ID."
  value       = try(azurerm_automation_account.main.identity[0].principal_id, null)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
