variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The public subnet IDs to associate with the ALB"
}

variable "alb_sg_id" {
  type        = string
  description = "The Security Group ID for the ALB"
}

variable "vault_instance_ids" {
  type        = list(string)
  description = "The list of Vault instance IDs to attach to the target group"
}

variable "project_name" {
  type        = string
  description = "Project name prefix used for resource naming"
  default     = "vault"
}

variable "vault_port" {
  type        = number
  description = "Port number for Vault API"
  default     = 8200
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

variable "listener_port" {
  type        = number
  description = "ALB listener port for incoming traffic"
  default     = 80
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
