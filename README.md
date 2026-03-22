# Cloud Resume Challenge — AWS + Terraform

Serverless resume website hosted on AWS, fully managed with Terraform.

## Architecture

```
User → Route53 → CloudFront → S3 (static site)
         ↓
      ACM (HTTPS)

Visitor Counter:
  Browser → API Gateway → Lambda → DynamoDB
```

## Project Structure

```
cloud-resume/
├── website/                # Static website files
│   ├── index.html
│   ├── style.css
│   └── script.js
├── lambda/                 # Lambda function source
│   └── visitor_counter.py
├── terraform/              # Infrastructure as Code
│   ├── main.tf             # Provider & backend config
│   ├── variables.tf        # Input variables
│   ├── terraform.tfvars.example
│   ├── s3_cloudfront.tf    # S3 bucket + CloudFront CDN
│   ├── dynamodb_lambda.tf  # DynamoDB + Lambda + IAM
│   ├── api_gateway.tf      # API Gateway REST API
│   ├── route53_acm.tf      # Route53 DNS + ACM certificate
│   └── outputs.tf          # Output values
└── README.md
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- AWS CLI configured (`aws configure`)
- A registered domain with a Route53 hosted zone

## Setup & Deploy

### 1. Configure variables

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your actual values
```

### 2. Import existing resources (if migrating from manual setup)

See the **Importing Existing Resources** section below.

### 3. Deploy with Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 4. Upload website files

```bash
aws s3 sync ../website/ s3://YOUR_BUCKET_NAME --delete
```

### 5. Update the API endpoint

After `terraform apply`, copy the `api_gateway_url` output and update `website/script.js` with the URL.

### 6. Invalidate CloudFront cache

```bash
aws cloudfront create-invalidation \
  --distribution-id YOUR_DISTRIBUTION_ID \
  --paths "/*"
```

## Importing Existing Resources

If you created resources manually and want Terraform to manage them, import each resource:

```bash
cd terraform

# S3 bucket
terraform import aws_s3_bucket.resume YOUR_BUCKET_NAME

# DynamoDB table
terraform import aws_dynamodb_table.visitor_counter visitor-counter

# Lambda function
terraform import aws_lambda_function.visitor_counter visitor-counter-function

# IAM role
terraform import aws_iam_role.lambda_role visitor-counter-function-role

# ACM certificate
terraform import aws_acm_certificate.resume arn:aws:acm:us-east-1:ACCOUNT_ID:certificate/CERT_ID

# CloudFront distribution
terraform import aws_cloudfront_distribution.resume DISTRIBUTION_ID

# Route53 record
terraform import aws_route53_record.resume ZONE_ID_resume.yourdomain.com_A

# API Gateway (import in order)
terraform import aws_api_gateway_rest_api.visitor_api API_ID
terraform import aws_api_gateway_resource.visitor_count API_ID/RESOURCE_ID
terraform import aws_api_gateway_method.post API_ID/RESOURCE_ID/POST
terraform import aws_api_gateway_integration.lambda_post API_ID/RESOURCE_ID/POST
terraform import aws_api_gateway_stage.prod API_ID/prod
```

After importing, run `terraform plan` to check for drift and resolve differences.

## Updating the Resume

1. Edit `website/index.html` (and CSS/JS as needed)
2. Sync to S3: `aws s3 sync website/ s3://YOUR_BUCKET --delete`
3. Invalidate CloudFront: `aws cloudfront create-invalidation --distribution-id ID --paths "/*"`

## License

MIT
