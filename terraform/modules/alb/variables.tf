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

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
