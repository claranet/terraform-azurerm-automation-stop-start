resource "azapi_update_resource" "workflow_init" {
  for_each = var.schedules

  type        = "Microsoft.Logic/workflows@2016-06-01"
  resource_id = azurerm_logic_app_workflow.main[each.key].id

  body = jsonencode({
    location   = var.location
    properties = jsondecode(file("${path.module}/files/workflow_init.json"))
  })
}

resource "azapi_update_resource" "workflow_update" {
  for_each = var.schedules

  type        = "Microsoft.Logic/workflows@2016-06-01"
  resource_id = azurerm_logic_app_workflow.main[each.key].id

  body = jsonencode({
    location   = var.location
    properties = jsondecode(templatefile("${path.module}/files/workflow.tftpl", local.workflow_vars[each.key]))
  })

  depends_on = [
    azapi_update_resource.workflow_init
  ]
}
