locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  automation_stop_start_name = coalesce(var.custom_name, data.azurecaf_name.automation_stop_start.result)
}
