variable "automation_account" {
  description = "The ID of an existing Automation account. If `null`, a new Automation account will be created."
  type = object({
    id = string
  })
  default = null
}

variable "sku_name" {
  description = "The SKU name of the Automation account."
  type        = string
  default     = "Basic"
  nullable    = false
}

variable "identity" {
  description = "Identity block information."
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string))
  })
  default  = {}
  nullable = false
}

variable "rbac_assignment_enabled" {
  description = "Enable RBAC assignment, allows Automation account to trigger Logic App."
  type        = bool
  default     = true
  nullable    = false
}

variable "schedules" {
  description = "Map of schedule objects."
  type = map(
    object({
      action               = string
      schedule_days        = list(string)
      schedule_hour        = number
      schedule_minute      = number
      schedule_timezone    = string
      target_resources_ids = list(string)
    })
  )

  validation {
    condition = alltrue([
      for schedule in var.schedules : contains(["start", "stop"], schedule.action)
    ])
    error_message = "Possible values for `action` parameter are 'start' and 'stop'."
  }
  validation {
    condition = alltrue([
      for schedule in var.schedules : schedule.schedule_minute >= 0 && schedule.schedule_minute <= 59
    ])
    error_message = "`schedule_minute` parameter must be a number between 0 and 59."
  }
  validation {
    condition = alltrue([
      for schedule in var.schedules : schedule.schedule_hour >= 0 && schedule.schedule_hour <= 23
    ])
    error_message = "`recurence_hour` parameter must be a number between 0 and 23."
  }
  validation {
    condition = alltrue([
      for schedule in var.schedules : alltrue([
        for day in schedule.schedule_days : contains([
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        ], day)
      ])
    ])
    error_message = "`schedule_days` parameter must contains a list of days: [\"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\", \"Sunday\"]."
  }
}
