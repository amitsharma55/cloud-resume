variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Custom domain name for the resume (e.g. resume.example.com)"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for the domain"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for the static website"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for visitor counter"
  type        = string
  default     = "visitor-counter"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "visitor-counter-function"
}

variable "api_gateway_name" {
  description = "Name of the API Gateway REST API"
  type        = string
  default     = "visitor-counter-api"
}
