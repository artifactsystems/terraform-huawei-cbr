# Simple Disk Backup

This directory contains a simple disk backup vault configuration with basic policy settings.

This example creates a CBR vault for disk backup with a simple daily backup policy.

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

- CBR vault for disk backup (100 GB, auto-expand enabled)
- Backup policy with daily backups at 2 AM
- Retention of last 7 backups

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

This example requires you to update `volume_ids` in `main.tf` with your actual EVS volume IDs before running.

## Outputs

| Name | Description |
|------|-------------|
| vault_id | ID of the CBR vault |
| vault_name | Name of the CBR vault |
| vault_status | Status of the CBR vault |
| policy_id | ID of the backup policy |
