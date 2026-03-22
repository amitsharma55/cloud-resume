# ─────────────────────────────────────────────
# Outputs
# ─────────────────────────────────────────────

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.resume.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.resume.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.resume.domain_name
}

output "website_url" {
  description = "Resume website URL"
  value       = "https://${var.domain_name}"
}

output "api_gateway_url" {
  description = "API Gateway invoke URL for visitor counter"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/visitor-count"
}

output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = aws_dynamodb_table.visitor_counter.name
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.visitor_counter.function_name
}
