resource "azurerm_automation_account" "main" {
  count = var.automation_account == null ? 1 : 0

  name = local.name

  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
