resource "azurerm_logic_app_workflow" "main" {
  for_each = var.schedules

  name     = local.workflow_name[each.key]
  location = azapi_resource.automation_connection.location

  resource_group_name = var.resource_group_name

  parameters = {
    "$connections" = jsonencode(
      {
        azureautomation = {
          connectionId   = format("%s/resourceGroups/%s/providers/Microsoft.Web/connections/%s", data.azurerm_subscription.main.id, var.resource_group_name, local.api_connection_name)
          connectionName = local.api_connection_name
          connectionProperties = {
            authentication = {
              type = "ManagedServiceIdentity"
            }
          }
          id = format("%s/providers/Microsoft.Web/locations/%s/managedApis/azureautomation", data.azurerm_subscription.main.id, var.location_cli)
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

  identity {
    type = "SystemAssigned"
  }

  tags = merge(local.default_tags, var.extra_tags)
}
