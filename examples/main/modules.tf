locals {
  mysql_id = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourceGroups/rg-app-dha-dev/providers/Microsoft.DBforMySQL/flexibleServers/mydha"
  vm_id    = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourceGroups/dha-test/providers/Microsoft.Compute/virtualMachines/dhavm"
  aks_id   = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourcegroups/rg-kub-dha-dev/providers/Microsoft.ContainerService/managedClusters/aks-kub-dha-euw-dev"
}

module "stop_start" {
  source  = "claranet/automation-stop-start/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  client_name         = var.client_name
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  location_cli        = module.azure_region.location_cli
  environment         = var.environment
  stack               = var.stack

  schedules = {
    start = {
      action = "start",
      schedule_days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ],
      schedule_hours    = 20,
      schedule_minutes  = 54,
      schedule_timezone = "Romance Standard Time",
      target_resource_ids = [
        local.mysql_id,
        local.vm_id,
        local.aks_id
      ],

    }
    stop = {
      action = "stop",
      schedule_days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ],
      schedule_hours    = 21,
      schedule_minutes  = 02,
      schedule_timezone = "Romance Standard Time",
      target_resource_ids = [
        local.mysql_id,
        local.vm_id,
        local.aks_id
      ],
    }
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}

resource "azurerm_role_assignment" "automation_vm" {
  scope                = local.vm_id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = module.stop_start.identity_principal_id
}

resource "azurerm_role_assignment" "automation_mysql" {
  scope                = local.mysql_id
  role_definition_name = "Contributor"
  principal_id         = module.stop_start.identity_principal_id
}

resource "azurerm_role_assignment" "automation_aks" {
  scope                = local.aks_id
  role_definition_name = "Contributor"
  principal_id         = module.stop_start.identity_principal_id
}
