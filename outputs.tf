################################################################################
# Vault Outputs
################################################################################

output "vault_id" {
  description = "ID of the CBR vault"
  value       = try(huaweicloud_cbr_vault.this[0].id, null)
}

output "vault_name" {
  description = "Name of the CBR vault"
  value       = try(huaweicloud_cbr_vault.this[0].name, null)
}

output "vault_status" {
  description = "Status of the CBR vault"
  value       = try(huaweicloud_cbr_vault.this[0].status, null)
}

output "vault_allocated" {
  description = "Allocated capacity of the vault in GB"
  value       = try(huaweicloud_cbr_vault.this[0].allocated, null)
}

output "vault_used" {
  description = "Used capacity of the vault in GB"
  value       = try(huaweicloud_cbr_vault.this[0].used, null)
}

output "vault_spec_code" {
  description = "Specification code of the vault"
  value       = try(huaweicloud_cbr_vault.this[0].spec_code, null)
}

output "vault_storage" {
  description = "Name of the bucket for the vault"
  value       = try(huaweicloud_cbr_vault.this[0].storage, null)
}

################################################################################
# Policy Outputs
################################################################################

output "policy_id" {
  description = "ID of the CBR policy (created or external)"
  value       = local.policy_id
}

output "policy_name" {
  description = "Name of the CBR policy (only available if policy was created by this module)"
  value       = try(huaweicloud_cbr_policy.this[0].name, null)
}

################################################################################
# Vault Set Resource Outputs
################################################################################

output "vault_set_resource_id" {
  description = "ID of the vault set resource"
  value       = try(huaweicloud_cbr_vault_set_resource.this[0].id, null)
}

################################################################################
# Organization Policy Outputs
################################################################################

output "organization_policy_id" {
  description = "ID of the organization policy"
  value       = try(huaweicloud_cbr_organization_policy.this[0].id, null)
}

output "organization_policy_name" {
  description = "Name of the organization policy"
  value       = try(huaweicloud_cbr_organization_policy.this[0].name, null)
}

output "organization_policy_status" {
  description = "Status of the organization policy"
  value       = try(huaweicloud_cbr_organization_policy.this[0].status, null)
}

output "organization_policy_domain_id" {
  description = "ID of the account to which the organization policy belongs"
  value       = try(huaweicloud_cbr_organization_policy.this[0].domain_id, null)
}

output "organization_policy_domain_name" {
  description = "Account to which the organization policy belongs"
  value       = try(huaweicloud_cbr_organization_policy.this[0].domain_name, null)
}
