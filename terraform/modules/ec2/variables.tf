variable "instance_type" {
  type        = string
  description = "The EC2 instance type for Bastion and Vault nodes"
  default     = "t3.medium"
}

variable "key_name" {
  type        = string
  description = "The name of the EC2 key pair to use"
}

variable "public_subnet_id" {
  type        = string
  description = "The public subnet ID for the Bastion host"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The list of private subnet IDs for the Vault nodes"
}

variable "bastion_sg_id" {
  type        = string
  description = "The Security Group ID for the Bastion host"
}

variable "vault_sg_id" {
  type        = string
  description = "The Security Group ID for the Vault nodes"
}

variable "instance_profile_name" {
  type        = string
  description = "The IAM instance profile name for the Vault nodes"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
