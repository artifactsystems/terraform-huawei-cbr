################################################################################
# General
################################################################################

variable "create" {
  description = "Whether to create CBR vault and policy resources"
  type        = bool
  default     = true
}

variable "create_vault" {
  description = "Whether to create the CBR vault"
  type        = bool
  default     = true
}

variable "create_policy" {
  description = "Whether to create the CBR backup policy"
  type        = bool
  default     = true
}

variable "create_organization_policy" {
  description = "Whether to create the CBR organization policy (enterprise level)"
  type        = bool
  default     = false
}

variable "region" {
  description = "Huawei Cloud region"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# CBR Vault
################################################################################

variable "vault_name" {
  description = "Name of the CBR vault"
  type        = string
}

variable "vault_type" {
  description = "Type of the CBR vault. Valid values: server, disk, turbo, workspace, vmware, file"
  type        = string
  default     = "disk"
  validation {
    condition     = contains(["server", "disk", "turbo", "workspace", "vmware", "file"], var.vault_type)
    error_message = "vault_type must be one of: server, disk, turbo, workspace, vmware, file"
  }
}

variable "protection_type" {
  description = "Protection type of the vault. Valid values: backup, replication"
  type        = string
  default     = "backup"
  validation {
    condition     = contains(["backup", "replication"], var.protection_type)
    error_message = "protection_type must be either backup or replication"
  }
}

variable "vault_size" {
  description = "Vault capacity in GB. Valid value range is 1 to 10,485,760"
  type        = number
  validation {
    condition     = var.vault_size >= 1 && var.vault_size <= 10485760
    error_message = "vault_size must be between 1 and 10,485,760 GB"
  }
}

variable "consistent_level" {
  description = "Consistent level of the vault. Valid values: crash_consistent, app_consistent. Only server type vaults support app_consistent"
  type        = string
  default     = "crash_consistent"
  validation {
    condition     = contains(["crash_consistent", "app_consistent"], var.consistent_level)
    error_message = "consistent_level must be either crash_consistent or app_consistent"
  }
}

variable "auto_expand" {
  description = "Enable auto capacity expansion for the backup protection type vault"
  type        = bool
  default     = false
}

variable "locked" {
  description = "Whether the vault is locked. A locked vault cannot be unlocked"
  type        = bool
  default     = false
}

variable "auto_bind" {
  description = "Whether automatic association is enabled"
  type        = bool
  default     = false
}

variable "bind_rules" {
  description = "Tags to filter resources for automatic association with auto_bind"
  type        = map(string)
  default     = {}
}

variable "enterprise_project_id" {
  description = "ID of the enterprise project to which the vault belongs"
  type        = string
  default     = null
}

variable "backup_name_prefix" {
  description = "Backup name prefix. If configured, the names of all automatic backups generated for the vault will use this prefix"
  type        = string
  default     = null
}

variable "is_multi_az" {
  description = "Whether multiple availability zones are used for backing up"
  type        = bool
  default     = false
}

variable "vault_tags" {
  description = "Additional tags for the vault"
  type        = map(string)
  default     = {}
}

variable "charging_mode" {
  description = "Charging mode of the vault. Valid values: prePaid, postPaid"
  type        = string
  default     = "postPaid"
  validation {
    condition     = contains(["prePaid", "postPaid"], var.charging_mode)
    error_message = "charging_mode must be either prePaid or postPaid"
  }
}

variable "period_unit" {
  description = "Charging period unit. Valid values: month, year. Required if charging_mode is prePaid"
  type        = string
  default     = null
  validation {
    condition     = var.period_unit == null || contains(["month", "year"], var.period_unit)
    error_message = "period_unit must be either month or year"
  }
}

variable "period" {
  description = "Charging period. If period_unit is month, value ranges from 1 to 9. If period_unit is year, value ranges from 1 to 5. Required if charging_mode is prePaid"
  type        = number
  default     = null
}

variable "auto_renew" {
  description = "Whether auto renew is enabled. Valid values: true, false"
  type        = string
  default     = "false"
  validation {
    condition     = contains(["true", "false"], var.auto_renew)
    error_message = "auto_renew must be either true or false"
  }
}

################################################################################
# Vault Resources (for disk type vault)
################################################################################

variable "volume_ids" {
  description = "List of EVS volume IDs to include in the backup. Used for disk type vault"
  type        = list(string)
  default     = []
}

################################################################################
# Vault Resources (for server type vault)
################################################################################

variable "server_id" {
  description = "ECS instance ID to be backed up. Used for server type vault"
  type        = string
  default     = null
}

variable "excluded_volume_ids" {
  description = "List of disk IDs to exclude from backup. Only for server type vault"
  type        = list(string)
  default     = []
}

################################################################################
# CBR Policy
################################################################################

variable "policy_name" {
  description = "Name of the backup policy"
  type        = string
  default     = null
}

variable "policy_enabled" {
  description = "Whether to enable the policy"
  type        = bool
  default     = true
}

variable "backup_quantity" {
  description = "Maximum number of retained backups. Value ranges from 2 to 99,999. Alternative to time_period"
  type        = number
  default     = null
  validation {
    condition     = var.backup_quantity == null || (var.backup_quantity >= 2 && var.backup_quantity <= 99999)
    error_message = "backup_quantity must be between 2 and 99,999"
  }
}

variable "time_period" {
  description = "Duration in days for retained backups. Value ranges from 2 to 99,999. Alternative to backup_quantity"
  type        = number
  default     = null
  validation {
    condition     = var.time_period == null || (var.time_period >= 2 && var.time_period <= 99999)
    error_message = "time_period must be between 2 and 99,999"
  }
}

variable "time_zone" {
  description = "UTC time zone, e.g. UTC+08:00. Only available if long_term_retention is set"
  type        = string
  default     = "UTC+08:00"
}

################################################################################
# Policy Backup Cycle
################################################################################

variable "backup_cycle_days" {
  description = "Weekly backup day of backup schedule. Supports: MO, TU, WE, TH, FR, SA, SU. Separated by comma without spaces. Alternative to backup_cycle_interval"
  type        = string
  default     = null
}

variable "backup_cycle_interval" {
  description = "Interval in days of backup schedule. Valid value ranges from 1 to 30. Alternative to backup_cycle_days"
  type        = number
  default     = null
  validation {
    condition     = var.backup_cycle_interval == null || (var.backup_cycle_interval >= 1 && var.backup_cycle_interval <= 30)
    error_message = "backup_cycle_interval must be between 1 and 30"
  }
}

variable "execution_times" {
  description = "List of backup times in UTC format (HH:MM). Minutes must be 00 and hours cannot be repeated"
  type        = list(string)
  default     = ["02:00"]
}

################################################################################
# Policy Long-term Retention
################################################################################

variable "long_term_retention" {
  description = "Long-term retention rules configuration"
  type = object({
    daily                = optional(number)
    weekly               = optional(number)
    monthly              = optional(number)
    yearly               = optional(number)
    full_backup_interval = optional(number, -1)
  })
  default = null
}

################################################################################
# Policy Replication (for replication type)
################################################################################

variable "destination_region" {
  description = "Name of the replication destination region. Required if protection_type is replication"
  type        = string
  default     = null
}

variable "destination_project_id" {
  description = "ID of the replication destination project. Required if protection_type is replication"
  type        = string
  default     = null
}

################################################################################
# Vault Set Resource (optional)
################################################################################

variable "enable_vault_set_resource" {
  description = "Whether to use vault_set_resource to manage resources separately"
  type        = bool
  default     = false
}

variable "vault_set_resource_action" {
  description = "Action for vault_set_resource. Valid values: suspend (enable backup), unsuspend (disable backup)"
  type        = string
  default     = "suspend"
  validation {
    condition     = contains(["suspend", "unsuspend"], var.vault_set_resource_action)
    error_message = "vault_set_resource_action must be either suspend or unsuspend"
  }
}

################################################################################
# Organization Policy
################################################################################

variable "organization_policy_name" {
  description = "Name of the organization policy"
  type        = string
  default     = null
}

variable "organization_policy_description" {
  description = "Description of the organization policy"
  type        = string
  default     = null
}

variable "organization_policy_enabled" {
  description = "Whether to enable the organization policy"
  type        = bool
  default     = true
}

variable "effective_scope" {
  description = "Effective scope of the organization policy"
  type        = string
  default     = null
}

################################################################################
# Organization Policy Operation Definition
################################################################################

variable "org_policy_day_backups" {
  description = "Maximum number of daily backups that can be retained. Value ranges from 0 to 100"
  type        = number
  default     = null
  validation {
    condition     = var.org_policy_day_backups == null || (var.org_policy_day_backups >= 0 && var.org_policy_day_backups <= 100)
    error_message = "org_policy_day_backups must be between 0 and 100"
  }
}

variable "org_policy_week_backups" {
  description = "Maximum number of weekly backups that can be retained. Value ranges from 0 to 100"
  type        = number
  default     = null
  validation {
    condition     = var.org_policy_week_backups == null || (var.org_policy_week_backups >= 0 && var.org_policy_week_backups <= 100)
    error_message = "org_policy_week_backups must be between 0 and 100"
  }
}

variable "org_policy_month_backups" {
  description = "Maximum number of monthly backups that can be retained. Value ranges from 0 to 100"
  type        = number
  default     = null
  validation {
    condition     = var.org_policy_month_backups == null || (var.org_policy_month_backups >= 0 && var.org_policy_month_backups <= 100)
    error_message = "org_policy_month_backups must be between 0 and 100"
  }
}

variable "org_policy_year_backups" {
  description = "Maximum number of yearly backups that can be retained. Value ranges from 0 to 100"
  type        = number
  default     = null
  validation {
    condition     = var.org_policy_year_backups == null || (var.org_policy_year_backups >= 0 && var.org_policy_year_backups <= 100)
    error_message = "org_policy_year_backups must be between 0 and 100"
  }
}

variable "org_policy_max_backups" {
  description = "Maximum number of backups that can be automatically created. Value can be -1 or ranges from 0 to 99999. If -1, backups will not be cleared by quantity limit"
  type        = number
  default     = null
  validation {
    condition     = var.org_policy_max_backups == null || (var.org_policy_max_backups == -1 || (var.org_policy_max_backups >= 0 && var.org_policy_max_backups <= 99999))
    error_message = "org_policy_max_backups must be -1 or between 0 and 99,999"
  }
}

variable "org_policy_retention_duration_days" {
  description = "Duration of retaining a backup in days. Maximum value is 99999. If -1, backups will not be cleared by retention duration"
  type        = number
  default     = null
  validation {
    condition     = var.org_policy_retention_duration_days == null || (var.org_policy_retention_duration_days == -1 || (var.org_policy_retention_duration_days >= 0 && var.org_policy_retention_duration_days <= 99999))
    error_message = "org_policy_retention_duration_days must be -1 or between 0 and 99,999"
  }
}

variable "org_policy_timezone" {
  description = "Time zone where the user is located, e.g. UTC+08:00"
  type        = string
  default     = "UTC+08:00"
}

variable "org_policy_full_backup_interval" {
  description = "How often a full backup is performed after incremental backups. If -1, full backup will not be performed. Value ranges from -1 to 100"
  type        = number
  default     = -1
  validation {
    condition     = var.org_policy_full_backup_interval >= -1 && var.org_policy_full_backup_interval <= 100
    error_message = "org_policy_full_backup_interval must be between -1 and 100"
  }
}

################################################################################
# Organization Policy Trigger (iCalendar RFC 2445)
################################################################################

variable "org_policy_trigger_patterns" {
  description = "List of scheduling rules for policy execution in iCalendar RFC 2445 format. Up to 24 rules supported. Example: FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR;BYHOUR=16;BYMINUTE=00"
  type        = list(string)
  default     = ["FREQ=DAILY;BYHOUR=2;BYMINUTE=00"]
}

################################################################################
# Organization Policy Replication
################################################################################

variable "org_policy_destination_region" {
  description = "Destination region for replication. Required if operation_type is replication"
  type        = string
  default     = null
}

variable "org_policy_destination_project_id" {
  description = "Destination project ID for replication. Required if operation_type is replication"
  type        = string
  default     = null
}

variable "org_policy_enable_acceleration" {
  description = "Whether to enable acceleration to shorten replication time for cross-region replication"
  type        = string
  default     = null
  validation {
    condition     = var.org_policy_enable_acceleration == null || contains(["true", "false"], var.org_policy_enable_acceleration)
    error_message = "org_policy_enable_acceleration must be either true or false"
  }
}
