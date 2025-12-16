################################################################################
# CBR Module - Main Configuration
################################################################################

locals {
  create_vault               = var.create && var.create_vault
  create_policy              = var.create && var.create_policy
  create_organization_policy = var.create && var.create_organization_policy

  # Policy name - use provided or generate from vault name
  policy_name = var.policy_name != null ? var.policy_name : "${var.vault_name}-policy"

  # Organization policy name - use provided or generate from vault name
  organization_policy_name = var.organization_policy_name != null ? var.organization_policy_name : "${var.vault_name}-org-policy"

  # Vault resources configuration based on type
  vault_resources = var.vault_type == "disk" && length(var.volume_ids) > 0 ? [{
    includes  = var.volume_ids
    server_id = null
    excludes  = null
    }] : var.vault_type == "server" && var.server_id != null ? [{
    includes  = null
    server_id = var.server_id
    excludes  = var.excluded_volume_ids
  }] : []
}

################################################################################
# CBR Vault
################################################################################

resource "huaweicloud_cbr_vault" "this" {
  count = local.create_vault ? 1 : 0

  region                = var.region
  name                  = var.vault_name
  type                  = var.vault_type
  protection_type       = var.protection_type
  size                  = var.vault_size
  consistent_level      = var.vault_type == "server" || var.vault_type == "workspace" || var.vault_type == "vmware" || var.vault_type == "file" ? var.consistent_level : null
  auto_expand           = var.protection_type == "backup" ? var.auto_expand : null
  locked                = var.locked
  auto_bind             = var.auto_bind
  bind_rules            = var.auto_bind ? var.bind_rules : null
  enterprise_project_id = var.enterprise_project_id
  backup_name_prefix    = var.backup_name_prefix
  is_multi_az           = var.is_multi_az

  dynamic "resources" {
    for_each = local.vault_resources
    content {
      server_id = try(resources.value.server_id, null)
      excludes  = try(resources.value.excludes, null)
      includes  = try(resources.value.includes, null)
    }
  }

  dynamic "policy" {
    for_each = local.create_policy && local.create_vault ? [1] : []
    content {
      id = huaweicloud_cbr_policy.this[0].id
    }
  }

  tags = merge(
    var.tags,
    var.vault_tags,
    { "Name" = var.vault_name }
  )

  # Charging mode configuration
  charging_mode = var.charging_mode
  period_unit   = var.charging_mode == "prePaid" ? var.period_unit : null
  period        = var.charging_mode == "prePaid" ? var.period : null
  auto_renew    = var.charging_mode == "prePaid" ? var.auto_renew : null
}

################################################################################
# CBR Policy
################################################################################

resource "huaweicloud_cbr_policy" "this" {
  count = local.create_policy ? 1 : 0

  region                 = var.region
  name                   = local.policy_name
  type                   = var.protection_type
  enabled                = var.policy_enabled
  backup_quantity        = var.backup_quantity
  time_period            = var.time_period
  time_zone              = var.long_term_retention != null ? var.time_zone : null
  destination_region     = var.protection_type == "replication" ? var.destination_region : null
  destination_project_id = var.protection_type == "replication" ? var.destination_project_id : null

  dynamic "backup_cycle" {
    for_each = [1]
    content {
      days            = var.backup_cycle_days
      interval        = var.backup_cycle_interval
      execution_times = var.execution_times
    }
  }

  dynamic "long_term_retention" {
    for_each = var.long_term_retention != null ? [var.long_term_retention] : []
    content {
      daily                = try(long_term_retention.value.daily, null)
      weekly               = try(long_term_retention.value.weekly, null)
      monthly              = try(long_term_retention.value.monthly, null)
      yearly               = try(long_term_retention.value.yearly, null)
      full_backup_interval = try(long_term_retention.value.full_backup_interval, -1)
    }
  }
}

################################################################################
# CBR Organization Policy
################################################################################

resource "huaweicloud_cbr_organization_policy" "this" {
  count = local.create_organization_policy ? 1 : 0

  region          = var.region
  name            = local.organization_policy_name
  description     = var.organization_policy_description
  operation_type  = var.protection_type
  policy_name     = local.policy_name
  policy_enabled  = var.organization_policy_enabled
  effective_scope = var.effective_scope

  policy_operation_definition {
    day_backups             = var.org_policy_day_backups
    week_backups            = var.org_policy_week_backups
    month_backups           = var.org_policy_month_backups
    year_backups            = var.org_policy_year_backups
    max_backups             = var.org_policy_max_backups
    retention_duration_days = var.org_policy_retention_duration_days
    timezone                = var.org_policy_timezone
    full_backup_interval    = var.org_policy_full_backup_interval

    # Replication settings
    destination_region     = var.protection_type == "replication" ? var.org_policy_destination_region : null
    destination_project_id = var.protection_type == "replication" ? var.org_policy_destination_project_id : null
    enable_acceleration    = var.protection_type == "replication" ? var.org_policy_enable_acceleration : null
  }

  policy_trigger {
    properties {
      pattern = var.org_policy_trigger_patterns
    }
  }
}

################################################################################
# CBR Vault Set Resource (optional)
################################################################################

resource "huaweicloud_cbr_vault_set_resource" "this" {
  count = local.create_vault && var.enable_vault_set_resource && length(local.vault_resources) > 0 ? 1 : 0

  region       = var.region
  vault_id     = huaweicloud_cbr_vault.this[0].id
  resource_ids = var.vault_type == "disk" ? var.volume_ids : var.server_id != null ? [var.server_id] : []
  action       = var.vault_set_resource_action
}
