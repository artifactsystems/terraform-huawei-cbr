# Server Backup

This directory contains an ECS server backup vault configuration with crash-consistent or app-consistent backup.

This example creates a CBR vault for backing up entire ECS instances with the option to exclude specific volumes.

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

- CBR vault for server backup (200 GB)
- Backup policy with daily backups at 2 AM
- Retention of last 14 backups (2 weeks)
- Option to exclude specific volumes from backup

## Consistent Levels

- **crash_consistent**: Crash-consistent backup (default). Suitable for most scenarios.
- **app_consistent**: Application-consistent backup. Ensures data consistency at the application level. Requires the CBR agent to be installed on the ECS instance.

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
- Update `server_id` in `main.tf` with your actual ECS instance ID
- (Optional) Specify volumes to exclude in `excluded_volume_ids`
- Choose appropriate `consistent_level` (crash_consistent or app_consistent)
- For app_consistent backups: CBR agent must be installed on the ECS instance

## Outputs

| Name | Description |
|------|-------------|
| vault_id | ID of the CBR vault |
| vault_name | Name of the CBR vault |
| vault_status | Status of the CBR vault |
| policy_id | ID of the backup policy |
