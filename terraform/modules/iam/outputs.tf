output "instance_profile_name" {
  value       = aws_iam_instance_profile.vault.name
  description = "The name of the IAM instance profile"
}

output "role_arn" {
  value       = aws_iam_role.vault.arn
  description = "The ARN of the IAM role"
}
