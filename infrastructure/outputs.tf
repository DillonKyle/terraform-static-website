output "websiteendpoint" {
  value = module.s3_static_website.websiteendpoint
}
output "aws_account_id" {
  description = "The AWS Account ID being accessed"
  value       = data.aws_caller_identity.current.account_id
}
