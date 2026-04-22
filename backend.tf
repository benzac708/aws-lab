# ============================================================================
# REMOTE STATE INFRASTRUCTURE
# ============================================================================
# This file creates the S3 bucket and DynamoDB table for remote Terraform state
# Run: terraform init && terraform apply
# After state infrastructure is created, uncomment the backend block below
# and re-run: terraform init -migrate-state
# ============================================================================

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${var.project_name}-${var.environment}"

  tags = merge(local.common_tags, {
    Name = "terraform-state-${var.project_name}-${var.environment}"
  })
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(local.common_tags, {
    Name = "terraform-lock"
  })
}

# ============================================================================
# REMOTE BACKEND (Uncomment after state resources are created)
# ============================================================================
# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-zachara-dev"
#     key            = "aws-lab-vpc/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock"
#   }
# }

# Alternative: Use backend.hcl file
# terraform init -backend-config=backend.hcl