#!/usr/bin/env bash
set -euo pipefail

terraform fmt -check -diff
terraform init -backend=false -input=false
terraform validate

# Trivy runs as the dedicated CI step in the workflow.
