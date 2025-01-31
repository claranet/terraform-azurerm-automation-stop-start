locals {
  mysql_id = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourceGroups/rg-app-dha-dev/providers/Microsoft.DBforMySQL/flexibleServers/mydha"
  vm_id    = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourceGroups/dha-test/providers/Microsoft.Compute/virtualMachines/dhavm"
  aks_id   = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourcegroups/rg-kub-dha-dev/providers/Microsoft.ContainerService/managedClusters/aks-kub-dha-euw-dev"
}

module "stop_start" {
  source  = "claranet/automation-stop-start/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_cli   = module.azure_region.location_cli
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  automation_account = {
    id = module.run.automation_account_id
  }

  schedules = {
    start = {
      action = "start"
      schedule_days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]
      schedule_hour     = 20
      schedule_minute   = 54
      schedule_timezone = "Romance Standard Time"
      target_resources_ids = [
        local.mysql_id,
        local.vm_id,
        local.aks_id,
      ]
    }
    stop = {
      action = "stop"
      schedule_days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]
      schedule_hour     = 21
      schedule_minute   = 2
      schedule_timezone = "Romance Standard Time"
      target_resources_ids = [
        local.mysql_id,
        local.vm_id,
        local.aks_id,
      ]
    }
  }

  logs_destinations_ids = [
    module.run.log_analytics_workspace_id,
    module.run.logs_storage_account_id,
  ]

  extra_tags = {
    foo = "bar"
  }
}

resource "azurerm_role_assignment" "automation_vm" {
  scope                = local.vm_id
  principal_id         = module.stop_start.identity_principal_id
  role_definition_name = "Virtual Machine Contributor"
}

resource "azurerm_role_assignment" "automation_mysql" {
  scope                = local.mysql_id
  principal_id         = module.stop_start.identity_principal_id
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "automation_aks" {
  scope                = local.aks_id
  principal_id         = module.stop_start.identity_principal_id
  role_definition_name = "Contributor"
}
