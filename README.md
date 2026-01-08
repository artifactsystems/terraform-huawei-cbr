# HuaweiCloud CBR Terraform Module

Terraform module which creates CBR (Cloud Backup and Recovery) resources on HuaweiCloud.

## Usage

```hcl
module "cbr" {
  source = "github.com/artifactsystems/terraform-huawei-cbr?ref=v1.0.0"

  vault_name      = "my-backup-vault"
  vault_type      = "disk"
  protection_type = "backup"
  vault_size      = 100
  auto_expand     = true

  volume_ids = [
    "volume-id-1",
    "volume-id-2"
  ]

  # Simple backup policy - daily backup at 2 AM
  backup_cycle_interval = 1
  execution_times        = ["02:00"]
  backup_quantity       = 7 # Keep last 7 backups

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Features

This module supports the following CBR features:

### Core Features
- ✅ **CBR Vault**: Create and manage backup vaults for various resource types
- ✅ **Multiple Vault Types**: Support for server, disk, turbo, workspace, vmware, and file vault types
- ✅ **Protection Types**: Both backup and replication protection types
- ✅ **Backup Policy**: Configurable backup policies with scheduling and retention
- ✅ **Shared Policy Support**: Use a single policy across multiple vaults or attach existing policies
- ✅ **Long-term Retention**: Advanced retention rules with daily/weekly/monthly/yearly backups
- ✅ **Auto-expand**: Automatic vault capacity expansion when needed
- ✅ **Multi-AZ**: Multi-availability zone backup support for high availability

### Backup Scheduling
- ✅ **Flexible Scheduling**: Daily or interval-based backup schedules
- ✅ **Multiple Execution Times**: Configure multiple backup times per day
- ✅ **Weekly Schedule**: Day-of-week based scheduling (MO, TU, WE, TH, FR, SA, SU)

### Retention & Lifecycle
- ✅ **Quantity-based Retention**: Retain backups by count (2-99,999 backups)
- ✅ **Time-based Retention**: Retain backups by duration (2-99,999 days)
- ✅ **Long-term Retention Rules**: Daily, weekly, monthly, and yearly backup retention
- ✅ **Full Backup Interval**: Configurable full backup frequency after incremental backups

### Resource Management
- ✅ **Disk Backup**: Backup specific EVS volumes (disk type vault)
- ✅ **Server Backup**: Backup entire ECS instances with volume exclusion support (server type vault)
- ✅ **Auto-bind**: Automatic resource association based on tags
- ✅ **Vault Set Resource**: Separate resource management for fine-grained control

### Replication
- ✅ **Cross-region Replication**: Replicate backups to different regions
- ✅ **Cross-project Replication**: Replicate backups to different projects
- ✅ **Replication Acceleration**: Enable acceleration for faster cross-region replication

### Billing & Operations
- ✅ **Charging Modes**: PrePaid and PostPaid billing options
- ✅ **Auto-renew**: Automatic renewal for PrePaid vaults
- ✅ **Vault Locking**: Protection against accidental deletion
- ✅ **Backup Name Prefix**: Customizable naming for automatic backups

### Security & Compliance
- ✅ **Tag Management**: Comprehensive tagging support for all resources
- ✅ **Enterprise Project Integration**: Support for HuaweiCloud Enterprise Projects
- ✅ **Consistent Levels**: Crash-consistent and app-consistent backup levels (for server type)

## Examples

- [simple](./examples/simple) - Simple disk backup vault with basic policy configuration
- [complete](./examples/complete) - Complete disk backup vault with long-term retention rules and advanced scheduling
- [server](./examples/server) - ECS server backup vault with crash-consistent or app-consistent backup

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/artifactsystems/terraform-huawei-cbr/issues/new) section.

Full contributing [guidelines are covered here](.github/CONTRIBUTING.md).
