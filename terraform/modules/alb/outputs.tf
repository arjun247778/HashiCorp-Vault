output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "The DNS name of the ALB"
}

output "target_group_arn" {
  value       = aws_lb_target_group.vault.arn
  description = "The ARN of the Target Group"
}
