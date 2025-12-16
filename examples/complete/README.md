# Complete Disk Backup with Long-term Retention

This directory contains a complete disk backup vault configuration with long-term retention rules and advanced scheduling.

This example creates a CBR vault with comprehensive backup policy including long-term retention rules for daily, weekly, monthly, and yearly backups.

## Usage

To run this example, execute:

```bash
terraform init
terraform plan
terraform apply
```

**Note:** This example may create billable resources (CBR vault). Run `terraform destroy` when you no longer need these resources.

## Configuration

This example creates:

- CBR vault for disk backup (500 GB, auto-expand enabled)
- Backup policy with weekly schedule (Monday, Wednesday, Friday at 2 AM)
- Long-term retention rules:
  - Daily backups: Keep latest backup of each day for 7 days
  - Weekly backups: Keep latest backup of each week for 4 weeks
  - Monthly backups: Keep latest backup of each month for 6 months
  - Yearly backups: Keep latest backup of each year for 2 years
- Full backup every 10 incremental backups
- Custom backup name prefix

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| huaweicloud | >= 1.79.0 |

## Providers

| Name | Version |
|------|---------|
| huaweicloud | >= 1.79.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cbr | ../../ | n/a |

## Inputs

This example requires you to:
- Update `volume_ids` in `main.tf` with your actual EVS volume IDs
- Adjust `time_zone` to match your timezone (default: UTC+03:00)

## Outputs

| Name | Description |
|------|-------------|
| vault_id | ID of the CBR vault |
| vault_name | Name of the CBR vault |
| vault_status | Status of the CBR vault |
| vault_allocated | Allocated capacity of the vault in GB |
| vault_used | Used capacity of the vault in GB |
| policy_id | ID of the backup policy |
| policy_name | Name of the backup policy |
