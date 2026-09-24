#!/usr/bin/env bash
set -euo pipefail

terraform fmt -check -diff
terraform init -backend=false -input=false
terraform validate

TRIVY_CACHE_DIR="${TRIVY_CACHE_DIR:-$PWD/.trivy-cache}"
export TRIVY_CACHE_DIR
trivy config --severity HIGH,CRITICAL --exit-code 1 .
