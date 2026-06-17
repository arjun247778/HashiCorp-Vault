output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = module.subnets.public_subnet_ids
  description = "The IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = module.subnets.private_subnet_ids
  description = "The IDs of the private subnets"
}

output "bastion_public_ip" {
  value       = module.ec2.bastion_public_ip
  description = "The public IP of the Bastion host"
}

output "vault_private_ips" {
  value       = module.ec2.vault_private_ips
  description = "The private IPs of the Vault instances"
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The DNS name of the ALB"
}

output "vault_url" {
  value       = "http://${module.alb.alb_dns_name}"
  description = "The URL to access the Vault UI"
}
