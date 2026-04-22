# aws-lab

Terraform lab for AWS infrastructure.

## What it builds

- VPC with public, private, and data subnets
- Internet gateway and NAT gateway
- Bastion host and security groups
- S3 and DynamoDB state resources
- VPC endpoints for private AWS service access

## Usage

```bash
terraform init
terraform plan
terraform apply
# Test your resources
terraform destroy
```

## Files

- `main.tf`: core AWS resources
- `backend.tf`: state bucket and lock table resources
- `variables.tf`: input variables
- `terraform.tfvars.example`: starter values
