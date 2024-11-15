resource "azapi_resource" "automation_connection" {
  type     = "Microsoft.Web/connections@2016-06-01"
  name     = local.api_connection_name
  location = var.location

  parent_id                 = data.azurerm_resource_group.main.id
  schema_validation_enabled = false

  body = jsonencode({
    properties = {
      customParameterValues      = {}
      alternativeParameterValues = {}
      parameterValueType         = "Alternative"

      api = {
        name        = "azureautomation"
        displayName = "Azure Automation"
        description = "Azure Automation provides tools to manage your cloud and on-premises infrastructure seamlessly."
        id          = "/subscriptions/${data.azurerm_subscription.main.subscription_id}/providers/Microsoft.Web/locations/${var.location_cli}/managedApis/azureautomation"
        type        = "Microsoft.Web/locations/managedApis"
      }
    }
  })
}
