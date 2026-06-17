output "public_subnet_ids" {
  value       = [for subnet in aws_subnet.public : subnet.id]
  description = "The IDs of the public subnets"
}

output "public_subnet_map" {
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
  description = "Map of AZ to public subnet ID"
}

output "private_subnet_ids" {
  value       = [for subnet in aws_subnet.private : subnet.id]
  description = "The IDs of the private subnets"
}

output "private_subnet_map" {
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
  description = "Map of AZ to private subnet ID"
}

output "private_route_table_id" {
  value       = aws_route_table.private.id
  description = "The ID of the private route table"
}
