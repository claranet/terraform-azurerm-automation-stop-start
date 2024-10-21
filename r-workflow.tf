resource "azurerm_logic_app_workflow" "main" {
  for_each            = var.schedules
  name                = local.workflow_name[each.key]
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }

  parameters = {
    "$connections" = jsonencode(
      {
        azureautomation = {
          connectionId   = "/subscriptions/${data.azurerm_subscription.main.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Web/connections/${local.api_connection_name}"
          connectionName = local.api_connection_name
          connectionProperties = {
            authentication = {
              type = "ManagedServiceIdentity"
            }
          }
          id = "/subscriptions/${data.azurerm_subscription.main.subscription_id}/providers/Microsoft.Web/locations/${var.location_cli}/managedApis/azureautomation"
        }
      }
    )
  }

  workflow_parameters = {
    "$connections" = jsonencode(
      {
        defaultValue = {}
        type         = "Object"
      }
    )
  }

  depends_on = [
    azapi_resource.automation_connection,
  ]
}
