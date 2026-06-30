variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "igw_id" {
  type        = string
  description = "The ID of the Internet Gateway"
}

variable "public_subnet_cidrs" {
  type        = map(string)
  description = "Map of AZ to CIDR block for public subnets"
}

variable "private_subnet_cidrs" {
  type        = map(string)
  description = "Map of AZ to CIDR block for private subnets"
}

variable "project_name" {
  type        = string
  description = "Project name prefix used for resource naming"
  default     = "vault"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
