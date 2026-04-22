# aws-lab

Terraform labs for AWS infrastructure.

## Labs

- `lab-minimal/`: EC2 + security group + key pair
- `lab-vpc/`: Full VPC with public subnet, NAT gateway

## Usage

```bash
cd lab-minimal
terraform init
terraform plan
terraform apply
# Test your resources
terraform destroy
```

## What it demonstrates

- `terraform init`, `plan`, `apply`, `destroy` lifecycle
- AWS provider configuration
- EC2 instance provisioning
- Security group rules
- VPC networking basics