data "azurecaf_name" "api_connection" {
  name        = var.stack
  prefixes    = compact([local.name_prefix, "apic"])
  suffixes    = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug    = true
  clean_input = true
  separator   = "-"
}

data "azurecaf_name" "workflow" {
  name        = var.stack
  prefixes    = compact([local.name_prefix, "wkf"])
  suffixes    = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug    = true
  clean_input = true
  separator   = "-"
}

data "azurecaf_name" "automation" {
  name          = var.stack
  resource_type = "azurerm_automation_account"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "runbook" {
  name          = var.stack
  resource_type = "azurerm_automation_runbook"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}
