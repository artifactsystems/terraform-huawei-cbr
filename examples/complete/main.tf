provider "huaweicloud" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "tr-west-1"

  tags = {
    Name       = local.name
    Example    = local.name
    GithubRepo = "terraform-huawei-cbr"
    GithubOrg  = "artifactsystems"
  }
}

################################################################################
# CBR Module - Complete Example with Long-term Retention
################################################################################

module "cbr" {
  source = "../../"

  vault_name      = "${local.name}-vault"
  vault_type      = "disk"
  protection_type = "backup"
  vault_size      = 500

  # Auto-expand vault when needed
  auto_expand = true

  # Volume IDs to backup (replace with your actual volume IDs)
  volume_ids = [
    # "volume-id-1",
    # "volume-id-2"
  ]

  # Backup policy configuration
  policy_name = "${local.name}-backup-policy"

  # Weekly backup schedule (every Monday, Wednesday, Friday at 2 AM)
  backup_cycle_days = "MO,WE,FR"
  execution_times   = ["02:00"]

  # Retention: Choose ONE of the following options:
  # Option 1: Keep last 30 backups (by quantity)
  backup_quantity = 30
  # Option 2: Keep backups for 60 days (by time period)
  # time_period = 60
  # Note: backup_quantity and time_period are alternatives - use only one

  # Long-term retention rules
  # These rules work together with backup_quantity or time_period
  # They specify how many backups to keep for each time period (day/week/month/year)
  long_term_retention = {
    daily                = 7  # Keep latest backup of each day for 7 days
    weekly               = 4  # Keep latest backup of each week for 4 weeks
    monthly              = 6  # Keep latest backup of each month for 6 months
    yearly               = 2  # Keep latest backup of each year for 2 years
    full_backup_interval = 10 # Full backup every 10 incremental backups
  }

  # Time zone is required when long_term_retention is configured
  time_zone = "UTC+03:00"

  # Backup name prefix for automatic backups
  backup_name_prefix = "${local.name}-auto"

  tags = local.tags

  vault_tags = {
    Purpose     = "disk-backup"
    BackupLevel = "complete"
  }
}
