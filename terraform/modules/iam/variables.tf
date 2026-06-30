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
