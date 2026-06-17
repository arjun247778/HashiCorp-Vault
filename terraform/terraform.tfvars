aws_region   = "us-east-1"
project_name = "vault-ha"
environment  = "production"

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

allowed_ip    = "0.0.0.0/0" # Replace with your public IP for better security (e.g. "203.0.113.5/32")
instance_type = "t3.medium"
key_name      = "vault-key" # Ensure this key pair is created in AWS us-east-1 region

state_bucket_name = "vault-terraform-state-570729420924"
