output "websiteendpoint" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
}
output "aws_account_id" {
  description = "The AWS Account ID being accessed"
  value       = data.aws_caller_identity.current.account_id
}
