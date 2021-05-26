#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2154

# Copyright 2021 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export storage_container_name="${TF_VAR_name}-terraform-statefiles"
export storage_account_name="${TF_VAR_name}statefiles"
export resource_group_name="${storage_account_name}-resource-group"

# Run common.sh script for variable declaration and validation
source "${ROOT}/scripts/common.sh"

# Generate Backend Template to store Terraform State files.
readonly backend_config="terraform {
  backend \"azurerm\" {
    resource_group_name  = \"${resource_group_name}\"
    storage_account_name = \"${storage_account_name}\"
    container_name       = \"${storage_container_name}\"
    key                  = \"terraform/${TF_VAR_environment}/\"
  }
}"

# Terraform initialize should run on env folder.
cd "${ROOT}/env"
echo -e "${backend_config}" > backend.tf

# Terraform initinalize the backend bucket
terraform init -input=false

# this will destroy all of your resources in the environment workspace.
terraform destroy -no-color -auto-approve

# Delete terraform workspace.
terraform workspace select default
terraform workspace delete "${TF_VAR_environment}"
