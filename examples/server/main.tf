provider "huaweicloud" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "tr-west-1"
}

################################################################################
# CBR Module - Server Backup Example
################################################################################

module "cbr" {
  source = "../../"

  vault_name      = "${local.name}-vault"
  vault_type      = "server"
  protection_type = "backup"
  vault_size      = 200

  # Consistent level for server backup
  consistent_level = "crash_consistent" # or "app_consistent" for application consistency

  # ECS instance ID to backup (replace with your actual ECS instance ID)
  server_id = "your-ecs-instance-id"

  # Optional: Exclude specific volumes from backup
  excluded_volume_ids = [
    # "volume-id-to-exclude"
  ]

  # Backup policy - daily backup at 2 AM
  backup_cycle_interval = 1
  execution_times       = ["02:00"]
  backup_quantity       = 14 # Keep last 14 backups (2 weeks)

  tags = {
    Environment = "test"
    Terraform   = "true"
    BackupType  = "server"
  }
}
