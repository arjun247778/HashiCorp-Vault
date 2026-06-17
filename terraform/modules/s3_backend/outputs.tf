output "bucket_id" {
  value       = aws_s3_bucket.state.id
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.state.arn
  description = "The ARN of the S3 bucket"
}
