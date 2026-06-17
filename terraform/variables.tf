variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
  default     = "vault-ha"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "production"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = map(string)
  description = "Map of AZ to CIDR block for public subnets"
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}

variable "private_subnet_cidrs" {
  type        = map(string)
  description = "Map of AZ to CIDR block for private subnets"
  default = {
    "us-east-1a" = "10.0.10.0/24"
    "us-east-1b" = "10.0.11.0/24"
    "us-east-1c" = "10.0.12.0/24"
  }
}

variable "allowed_ip" {
  type        = string
  description = "IP address allowed to access Bastion host via SSH"
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  type        = string
  description = "Instance type for Vault nodes"
  default     = "t3.medium"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name for Bastion and Vault hosts"
  default     = "vault-key"
}

variable "state_bucket_name" {
  type        = string
  description = "Name of the S3 bucket to create for Terraform state"
  default     = "vault-terraform-state-vault-ha-cluster"
}
