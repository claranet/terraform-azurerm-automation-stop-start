# Azure Stop/Start with Automation
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/automation-stop-start/azurerm/latest)

Azure module to deploy an Azure Stop/Start workbook with an Automation Account.

Supported Azure resources which can be managed by this module:
 - Azure Virtual Machine (both Linux or Windows)
 - Azure Kubernetes Cluster
 - Azure MySQL Flexible Server

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
locals {
  mysql_id = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourceGroups/rg-app-dha-dev/providers/Microsoft.DBforMySQL/flexibleServers/mydha"
  vm_id    = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourceGroups/dha-test/providers/Microsoft.Compute/virtualMachines/dhavm"
  aks_id   = "/subscriptions/12345678-abcd-1111-2222-000000000000/resourcegroups/rg-kub-dha-dev/providers/Microsoft.ContainerService/managedClusters/aks-kub-dha-euw-dev"
}

module "stop_start" {
  source  = "claranet/automation-stop-start/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  client_name         = var.client_name
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  location_cli        = module.azure_region.location_cli
  environment         = var.environment
  stack               = var.stack

  automation_account_id = module.run.automation_account_id

  schedules = {
    start = {
      action = "start",
      schedule_days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ],
      schedule_hours    = 20,
      schedule_minutes  = 54,
      schedule_timezone = "Romance Standard Time",
      target_resource_ids = [
        local.mysql_id,
        local.vm_id,
        local.aks_id
      ],

    }
    stop = {
      action = "stop",
      schedule_days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ],
      schedule_hours    = 21,
      schedule_minutes  = 02,
      schedule_timezone = "Romance Standard Time",
      target_resource_ids = [
        local.mysql_id,
        local.vm_id,
        local.aks_id
      ],
    }
  }

  logs_destinations_ids = [
    module.run.logs_storage_account_id,
    module.run.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}

resource "azurerm_role_assignment" "automation_vm" {
  scope                = local.vm_id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = module.stop_start.identity_principal_id
}

resource "azurerm_role_assignment" "automation_mysql" {
  scope                = local.mysql_id
  role_definition_name = "Contributor"
  principal_id         = module.stop_start.identity_principal_id
}

resource "azurerm_role_assignment" "automation_aks" {
  scope                = local.aks_id
  role_definition_name = "Contributor"
  principal_id         = module.stop_start.identity_principal_id
}
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 1.11 |
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 3.100 |
| local | ~> 2.4 |
| null | ~> 3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 7.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.automation_connection](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_automation_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_automation_runbook.start_stop](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_runbook) | resource |
| [azurerm_logic_app_workflow.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |
| [azurerm_role_assignment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [local_file.code_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.workflow_init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.workflow_update](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurecaf_name.api_connection](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.automation](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.runbook](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.workflow](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [local_file.start_stop](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_connection\_custom\_name | Custom api connection account name, generated if not set. | `string` | `""` | no |
| automation\_account\_id | The ID of the existing Automation Account. If null is specified, a new Automation Account will be created. | `string` | `null` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_name | Custom automation account name, generated if not set. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| identity | Identity block information. | <pre>object({<br/>    type         = optional(string, "SystemAssigned")<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `{}` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_cli | Short string for Azure location in CLI format. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| runbook\_custom\_name | Custom runbook name, generated if not set. | `string` | `""` | no |
| schedules | Schedules | <pre>map(<br/>    object({<br/>      action              = string<br/>      schedule_days       = list(string)<br/>      schedule_hours      = number<br/>      schedule_minutes    = number<br/>      schedule_timezone   = string<br/>      target_resource_ids = list(string)<br/>      }<br/>    )<br/>  )</pre> | n/a | yes |
| sku\_name | The SKU name of the Automation Account. | `string` | `"Basic"` | no |
| stack | Project stack name. | `string` | n/a | yes |
| workflow\_custom\_name | Custom workflow name, generated if not set. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Stop/Start with Automation ID. |
| identity\_principal\_id | Azure Stop/Start with Automation system identity principal ID. |
| module\_diagnostics | Diagnostics settings module outputs. |
| name | Azure Stop/Start with Automation name. |
| resource | Azure Stop/Start with Automation resource object. |
<!-- END_TF_DOCS -->

## Related documentation
