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

output "policy_id" {
  description = "ID of the backup policy"
  value       = module.cbr.policy_id
}
