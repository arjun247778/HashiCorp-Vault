variable "instance_type" {
  type        = string
  description = "The EC2 instance type for Vault nodes"
}

variable "bastion_instance_type" {
  type        = string
  description = "The EC2 instance type for the Bastion host"
  default     = "t3.micro"
}

variable "vault_node_count" {
  type        = number
  description = "Number of Vault server nodes to deploy"
  default     = 3
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

variable "bastion_volume_size" {
  type        = number
  description = "Root volume size in GB for the Bastion host"
  default     = 20
}

variable "vault_volume_size" {
  type        = number
  description = "Root volume size in GB for the Vault nodes"
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
