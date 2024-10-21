resource "null_resource" "workflow_init" {
  for_each = var.schedules
  triggers = {
    workflow = azurerm_logic_app_workflow.main[each.key].id
  }

  provisioner "local-exec" {
    command = "az logic workflow update --resource-group ${var.resource_group_name} --definition ${path.module}/files/workflow_init.json --name ${local.workflow_name[each.key]} --subscription ${data.azurerm_subscription.main.subscription_id}"
  }

}

resource "null_resource" "workflow_update" {
  for_each = var.schedules
  triggers = {
    workflow = azurerm_logic_app_workflow.main[each.key].id
    code     = templatefile("${path.module}/files/workflow.tftpl", local.workflow_vars[each.key])
  }

  provisioner "local-exec" {
    command = "az logic workflow update --resource-group ${var.resource_group_name} --definition ${format("workflow_code-%s.json", each.key)} --name ${local.workflow_name[each.key]} --subscription ${data.azurerm_subscription.main.subscription_id}"
  }

  depends_on = [
    local_file.code_file,
    null_resource.workflow_init
  ]
}

resource "local_file" "code_file" {
  for_each = var.schedules
  content  = templatefile("${path.module}/files/${local.code_template_filename}", local.workflow_vars[each.key])
  filename = format("workflow_code-%s.json", each.key)
}
