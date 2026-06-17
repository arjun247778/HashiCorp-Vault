output "bastion_sg_id" {
  value       = aws_security_group.bastion.id
  description = "The ID of the Bastion security group"
}

output "alb_sg_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the ALB security group"
}

output "vault_sg_id" {
  value       = aws_security_group.vault.id
  description = "The ID of the Vault security group"
}
