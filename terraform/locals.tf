locals {
  vpc_name = "${var.project_name}-${var.environment}-vpc"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
