resource "azapi_update_resource" "workflow_init" {
  for_each = azurerm_logic_app_workflow.main

  type = "Microsoft.Logic/workflows@2016-06-01"

  resource_id = each.value.id

  body = {
    location   = var.location_cli
    properties = jsondecode(file("${path.module}/files/workflow_init.json"))
  }

  lifecycle {
    ignore_changes = [
      body,
    ]
  }
}

resource "azapi_update_resource" "workflow_update" {
  for_each = azapi_update_resource.workflow_init

  type = "Microsoft.Logic/workflows@2016-06-01"

  resource_id = each.value.resource_id

  body = {
    location   = var.location_cli
    properties = jsondecode(templatefile("${path.module}/files/workflow.tftpl", local.workflow_vars[each.key]))
  }
}
