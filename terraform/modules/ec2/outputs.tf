output "bastion_instance_id" {
  value       = aws_instance.bastion.id
  description = "The ID of the Bastion host"
}

output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "The public IP of the Bastion host"
}

output "vault_instance_ids" {
  value       = aws_instance.vault[*].id
  description = "The IDs of the Vault instances"
}

output "vault_private_ips" {
  value       = aws_instance.vault[*].private_ip
  description = "The private IPs of the Vault instances"
}
