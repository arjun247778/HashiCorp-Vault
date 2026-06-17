output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "igw_id" {
  value       = aws_internet_gateway.this.id
  description = "The ID of the Internet Gateway"
}
