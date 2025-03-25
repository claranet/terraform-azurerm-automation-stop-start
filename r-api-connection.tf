resource "azapi_resource" "automation_connection" {
  type = "Microsoft.Web/connections@2016-06-01"

  name     = local.api_connection_name
  location = var.location

  parent_id = format("%s/resourceGroups/%s", data.azurerm_subscription.main.id, var.resource_group_name)

  schema_validation_enabled = false

  body = {
    properties = {
      alternativeParameterValues = {}
      customParameterValues      = {}
      parameterValueType         = "Alternative"
      api = {
        type        = "Microsoft.Web/locations/managedApis"
        id          = format("%s/providers/Microsoft.Web/locations/%s/managedApis/azureautomation", data.azurerm_subscription.main.id, var.location_cli)
        name        = "azureautomation"
        displayName = "Azure Automation"
        description = "Azure Automation provides tools to manage your cloud and on-premises infrastructure seamlessly."
      }
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
