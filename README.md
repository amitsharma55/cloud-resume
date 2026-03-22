# Cloud Resume — AWS + Terraform

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

### 1. Deploy with Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 2. Upload website files

```bash
aws s3 sync ../website/ s3://YOUR_BUCKET_NAME --delete
```

### 3. Invalidate CloudFront cache

```bash
aws cloudfront create-invalidation \
  --distribution-id YOUR_DISTRIBUTION_ID \
  --paths "/*"
```

## Updating the Resume

1. Edit `website/index.html` (and CSS/JS as needed)
2. Sync to S3: `aws s3 sync website/ s3://YOUR_BUCKET --delete`
3. Invalidate CloudFront: `aws cloudfront create-invalidation --distribution-id ID --paths "/*"`

## License

MIT
