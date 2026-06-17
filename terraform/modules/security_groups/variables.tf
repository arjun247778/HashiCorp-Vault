variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "allowed_ip" {
  type        = string
  description = "The CIDR block allowed to SSH into the Bastion Host (e.g. your-ip/32 or 0.0.0.0/0)"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
