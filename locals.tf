locals {
  automation_account_id   = var.automation_account == null ? one(azurerm_automation_account.main[*].id) : var.automation_account.id
  automation_account_name = reverse(split("/", local.automation_account_id))[0]

  recurences = {
    for key, value in var.schedules : key => {
      "reccurence" = {
        "evaluatedRecurrence" = {
          "frequency" = "Minute",
          "interval"  = 1
        },
        "recurrence" = {
          "frequency" = "Week",
          "interval"  = 1,
          "schedule" = {
            "hours" = [
              tostring(value.schedule_hours)
            ],
            "minutes" = [
              tostring(value.schedule_minutes)
            ],
            "weekDays" = value.schedule_days
          },
          "timeZone" = value.schedule_timezone
        },
        "type" = "Recurrence"
      }
    }
  }

  run_job_actions = {
    for key, value in var.schedules : key => {
      for target_resource_id in var.schedules[key].target_resource_ids : reverse(split("/", target_resource_id))[0] => {
        "runAfter" = {}
        "type"     = "ApiConnection"
        "inputs" = {
          "body" = {
            "properties" = {
              "parameters" = {
                "target_resource_id" = target_resource_id
                "action"             = var.schedules[key].action
              }
            }
          }
          "host" = {
            "connection" = {
              "name" = "@parameters('$connections')['azureautomation']['connectionId']"
            }
          }
          "method" = "put"
          "path"   = "/subscriptions/@{encodeURIComponent('${data.azurerm_subscription.main.subscription_id}')}/resourceGroups/@{encodeURIComponent('${var.resource_group_name}')}/providers/Microsoft.Automation/automationAccounts/@{encodeURIComponent('${local.name}')}/jobs"
          "queries" = {
            "runbookName"      = local.runbook_name,
            "wait"             = false,
            "x-ms-api-version" = "2015-10-31"
          }
        }
      }
    }
  }


  workflow_vars = {
    for key, value in var.schedules : key => {
      reccurences             = jsonencode(local.recurences[key])
      run_job_actions         = jsonencode(local.run_job_actions[key])
      subscription_id         = data.azurerm_subscription.main.subscription_id
      resource_group_name     = var.resource_group_name
      api_connection_name     = local.api_connection_name
      location_short          = var.location_cli
      automation_account_name = local.name
      runbook_name            = local.runbook_name
      action                  = "stop"
    }
  }
}
