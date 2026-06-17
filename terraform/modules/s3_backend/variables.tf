variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store Terraform state"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resources"
  default     = {}
}
