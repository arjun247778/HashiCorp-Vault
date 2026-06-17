# S3 Backend Bucket (Commented out because user already has a pre-created S3 state bucket)
# module "s3_backend" {
#   source      = "./modules/s3_backend"
#   bucket_name = var.state_bucket_name
#   tags        = local.common_tags
# }

# VPC Module
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = local.vpc_name
  tags     = local.common_tags
}

# Subnets Module (Handles multi-AZ public and private subnets)
module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.common_tags
}

# NAT Gateway Module (EIP, NAT GW, and Private Subnets Route)
module "nat_gateway" {
  source                 = "./modules/nat_gateway"
  public_subnet_id       = module.subnets.public_subnet_ids[0] # Place NAT GW in the first public subnet
  private_route_table_id = module.subnets.private_route_table_id
  tags                   = local.common_tags
}

# Security Groups Module (Bastion, ALB, and Vault SG)
module "security_groups" {
  source     = "./modules/security_groups"
  vpc_id     = module.vpc.vpc_id
  allowed_ip = var.allowed_ip
  tags       = local.common_tags
}

# IAM Module (Vault Instance Profile and Auto-Join Permissions)
module "iam" {
  source = "./modules/iam"
  tags   = local.common_tags
}

# EC2 Module (Bastion Host and 3 Vault Servers across private subnets)
module "ec2" {
  source                = "./modules/ec2"
  instance_type         = var.instance_type
  key_name              = var.key_name
  public_subnet_id      = module.subnets.public_subnet_ids[0] # Place Bastion in first public subnet
  private_subnet_ids    = module.subnets.private_subnet_ids
  bastion_sg_id         = module.security_groups.bastion_sg_id
  vault_sg_id           = module.security_groups.vault_sg_id
  instance_profile_name = module.iam.instance_profile_name
  tags                  = local.common_tags
}

# ALB Module (External Application Load Balancer and Target Group)
module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  alb_sg_id          = module.security_groups.alb_sg_id
  vault_instance_ids = module.ec2.vault_instance_ids
  tags               = local.common_tags
}
