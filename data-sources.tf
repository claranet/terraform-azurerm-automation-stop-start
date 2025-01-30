data "azurerm_subscription" "main" {}

data "local_file" "main" {
  filename = "${path.module}/files/start-stop-resource.ps1"
}
