provider "huaweicloud" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "tr-west-1"
}

################################################################################
# CBR Module - Simple Disk Backup Example
################################################################################

module "cbr" {
  source = "../../"

  vault_name      = "${local.name}-vault"
  vault_type      = "disk"
  protection_type = "backup"
  vault_size      = 100
  auto_expand     = true

  volume_ids = [
    # "volume-id-1",
    # "volume-id-2"
  ]

  # Simple backup policy - daily backup at 2 AM
  backup_cycle_interval = 1
  execution_times       = ["02:00"]
  backup_quantity       = 7 # Keep last 7 backups

  tags = {
    Environment = "test"
    Terraform   = "true"
  }
}
