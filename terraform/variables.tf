# ============================================================================
# General Project Settings
# ============================================================================

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "project_name" {
  type        = string
  description = "Name of the project, used as a prefix for all resource names"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g. production, staging, dev)"
}

# ============================================================================
# VPC & Networking
# ============================================================================

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = map(string)
  description = "Map of AZ to CIDR block for public subnets"
}

variable "private_subnet_cidrs" {
  type        = map(string)
  description = "Map of AZ to CIDR block for private subnets"
}

# ============================================================================
# Security
# ============================================================================

variable "allowed_ip" {
  type        = string
  description = "IP address/CIDR allowed to access Bastion host via SSH (e.g. 203.0.113.5/32)"
}

variable "ssh_port" {
  type        = number
  description = "SSH port for instance access"
  default     = 22
}

# ============================================================================
# EC2 Instances
# ============================================================================

variable "instance_type" {
  type        = string
  description = "Instance type for Vault nodes"
}

variable "bastion_instance_type" {
  type        = string
  description = "Instance type for the Bastion host"
  default     = "t3.micro"
}

variable "vault_node_count" {
  type        = number
  description = "Number of Vault server nodes to deploy"
  default     = 3
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name for Bastion and Vault hosts"
}

variable "bastion_volume_size" {
  type        = number
  description = "Root EBS volume size in GB for the Bastion host"
  default     = 20
}

variable "vault_volume_size" {
  type        = number
  description = "Root EBS volume size in GB for the Vault nodes"
  default     = 30
}

variable "volume_type" {
  type        = string
  description = "EBS volume type for all instances"
  default     = "gp3"
}

variable "ami_filter" {
  type        = string
  description = "AMI name filter pattern for Ubuntu"
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

# ============================================================================
# Vault Application Settings
# ============================================================================

variable "vault_api_port" {
  type        = number
  description = "Port number for the Vault API"
  default     = 8200
}

variable "vault_cluster_port" {
  type        = number
  description = "Port number for Vault cluster (Raft) communication"
  default     = 8201
}

# ============================================================================
# ALB Settings
# ============================================================================

variable "alb_listener_port" {
  type        = number
  description = "ALB listener port for incoming traffic"
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "Health check endpoint path for Vault"
  default     = "/v1/sys/health"
}

variable "health_check_matcher" {
  type        = string
  description = "HTTP status codes for healthy responses (200=active, 429=standby)"
  default     = "200,429"
}

# ============================================================================
# Terraform State
# ============================================================================

variable "state_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state storage"
}
