variable "public_subnet_id" {
  type        = string
  description = "The ID of the public subnet to place the NAT Gateway in"
}

variable "private_route_table_id" {
  type        = string
  description = "The ID of the private route table"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
