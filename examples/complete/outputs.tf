output "vault_id" {
  description = "ID of the CBR vault"
  value       = module.cbr.vault_id
}

output "vault_name" {
  description = "Name of the CBR vault"
  value       = module.cbr.vault_name
}

output "vault_status" {
  description = "Status of the CBR vault"
  value       = module.cbr.vault_status
}

output "vault_allocated" {
  description = "Allocated capacity of the vault in GB"
  value       = module.cbr.vault_allocated
}

output "vault_used" {
  description = "Used capacity of the vault in GB"
  value       = module.cbr.vault_used
}

output "policy_id" {
  description = "ID of the backup policy"
  value       = module.cbr.policy_id
}

output "policy_name" {
  description = "Name of the backup policy"
  value       = module.cbr.policy_name
}
