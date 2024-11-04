variable "automation_account_id" {
  description = "The ID of the existing Automation Account. If null is specified, a new Automation Account will be created."
  type        = string
  default     = null
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

variable "sku_name" {
  description = "The SKU name of the Automation Account."
  type        = string
  default     = "Basic"
  nullable    = false
}

variable "schedules" {
  description = "Schedules"
  type = map(
    object({
      action              = string
      schedule_days       = list(string)
      schedule_hours      = number
      schedule_minutes    = number
      schedule_timezone   = string
      target_resource_ids = list(string)
      }
    )
  )

  validation {
    condition = alltrue([
      for schedule in var.schedules : schedule.schedule_minutes >= 0 && schedule.schedule_minutes <= 59
    ])

    error_message = "The schedule_minutes variable must be a number between 0 and 59."
  }

  validation {
    condition = alltrue([
      for schedule in var.schedules : schedule.schedule_hours >= 0 && schedule.schedule_hours <= 23
    ])
    error_message = "The recurence_hours variable must be a number between 0 and 23."
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
          "Sunday"],
        day)
      ])
    ])
    error_message = "The recurence_days variable must contains a list of days : \"Monday\",\"Tuesday\",\"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\",\"Sunday\"."
  }
}
