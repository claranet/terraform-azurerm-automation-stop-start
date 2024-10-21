locals {
  mysql_id = "/subscriptions/6b750f26-85f7-4089-886e-c8453a8cd96c/resourceGroups/rg-app-dha-dev/providers/Microsoft.DBforMySQL/flexibleServers/mydha"
  vm_id    = "/subscriptions/6b750f26-85f7-4089-886e-c8453a8cd96c/resourceGroups/dha-test/providers/Microsoft.Compute/virtualMachines/dhavm"
  aks_id   = "/subscriptions/6b750f26-85f7-4089-886e-c8453a8cd96c/resourcegroups/rg-kub-dha-dev/providers/Microsoft.ContainerService/managedClusters/aks-kub-dha-euw-dev"
}

module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

data "azurerm_client_config" "current" {
}

module "resource_start_stop" {
  source = "git@git.fr.clara.net:claranet/david.hautbois/start-stop-vm.git"


  azure_subscription_id = data.azurerm_client_config.current.subscription_id
  resource_group_name   = module.rg.resource_group_name
  client_name           = var.client_name
  location              = module.azure_region.location
  location_short        = module.azure_region.location_short
  location_cli          = module.azure_region.location_cli
  environment           = var.environment
  stack                 = var.stack

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

}

resource "azurerm_role_assignment" "automation_vm" {
  scope                = local.vm_id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = module.resource_start_stop.automation_identity
}

resource "azurerm_role_assignment" "automation_mysql" {
  scope                = local.mysql_id
  role_definition_name = "Contributor"
  principal_id         = module.resource_start_stop.automation_identity
}

resource "azurerm_role_assignment" "automation_aks" {
  scope                = local.aks_id
  role_definition_name = "Contributor"
  principal_id         = module.resource_start_stop.automation_identity
}
