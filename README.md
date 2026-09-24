# aws-lab

Terraform lab for a small AWS network: public/private/data subnets, a NAT
Gateway, a bastion host, security groups, VPC endpoints, and bootstrapped S3 +
DynamoDB remote-state resources.

## What it builds

- VPC with public, private, and data subnets.

- Internet Gateway and NAT Gateway.

- Bastion host and explicit administrator-only SSH access.

- S3 versioning/encryption/public-access blocking and DynamoDB lock resources.

- S3, DynamoDB, SSM, EC2, and CloudWatch Logs VPC endpoints.

- Ubuntu 22.04 AMI lookup with an explicit override option.

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# Replace the documentation CIDR and SSH key path.
terraform init
terraform plan
terraform apply
```

Destroy only after confirming the target account and workspace:

```bash
terraform destroy
```

Remote state is a two-stage setup: the resources in `backend.tf` bootstrap S3
and DynamoDB, then the backend block is enabled with a reviewed `backend.hcl`
and `terraform init -migrate-state`. The repository does not claim that every
run uses remote state automatically.

## Verification

`terraform fmt -check`, `terraform init -backend=false`, and
`terraform validate` run in CI. The configuration does not include LocalStack;
the real AWS apply/destroy verification is recorded in the commit history and
must be repeated only with an explicit, disposable lab account.

## Security choices

- `allowed_ssh_cidr` is required and rejects `0.0.0.0/0`.

- State bucket versioning, encryption, and public-access blocking are enabled.

- Provider and module versions are locked in `.terraform.lock.hcl`.

- `terraform.tfvars` is ignored; only the example is committed.
