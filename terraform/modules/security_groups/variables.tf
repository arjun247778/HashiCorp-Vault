variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "allowed_ip" {
  type        = string
  description = "The CIDR block allowed to SSH into the Bastion Host (e.g. your-ip/32 or 0.0.0.0/0)"
}

variable "project_name" {
  type        = string
  description = "Project name prefix used for resource naming"
  default     = "vault"
}

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

variable "ssh_port" {
  type        = number
  description = "SSH port for instance access"
  default     = 22
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
