data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_subscription" "main" {}
