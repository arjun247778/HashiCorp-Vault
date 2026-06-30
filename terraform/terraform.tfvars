# ============================================================================
# General Project Settings
# ============================================================================

aws_region   = "us-east-1"
project_name = "vault-ha"
environment  = "production"

# ============================================================================
# VPC & Networking
# ============================================================================

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = {
  "us-east-1a" = "10.0.1.0/24"
  "us-east-1b" = "10.0.2.0/24"
  "us-east-1c" = "10.0.3.0/24"
}

private_subnet_cidrs = {
  "us-east-1a" = "10.0.10.0/24"
  "us-east-1b" = "10.0.11.0/24"
  "us-east-1c" = "10.0.12.0/24"
}

# ============================================================================
# Security
# ============================================================================

allowed_ip = "0.0.0.0/0" # Replace with your public IP for better security (e.g. "203.0.113.5/32")
ssh_port   = 22

# ============================================================================
# EC2 Instances
# ============================================================================

instance_type         = "t3.medium"
bastion_instance_type = "t3.micro"
vault_node_count      = 3
key_name              = "vault-key" # Ensure this key pair is created in AWS us-east-1 region
bastion_volume_size   = 20
vault_volume_size     = 30
volume_type           = "gp3"
ami_filter            = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"

# ============================================================================
# Vault Application Settings
# ============================================================================

vault_api_port     = 8200
vault_cluster_port = 8201

# ============================================================================
# ALB Settings
# ============================================================================

alb_listener_port    = 80
health_check_path    = "/v1/sys/health"
health_check_matcher = "200,429" # 200 = active leader, 429 = standby node

# ============================================================================
# Terraform State
# ============================================================================

state_bucket_name = "vault-terraform-state-570729420924"
