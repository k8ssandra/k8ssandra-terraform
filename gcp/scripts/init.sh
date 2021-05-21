#!/usr/bin/env bash

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
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Run common.sh script for validation
source "${ROOT}/scripts/common.sh"

# Set environment variables
# Create a gcs bucket through cli to store terraform statefiles
# Create google storage bucket for the terraform backend.
export bucket_name="${TF_VAR_name}-${TF_VAR_project_id}-statefiles"

# Create Google cloud storage bucket to store the state files. 
source "${ROOT}/gcp/scripts/make_bucket.py"

# Generate Backend Template to store Terraform State files.
readonly backend_config="terraform {
  backend \"gcs\" {
    bucket = \"${bucket_name}\"
    prefix = \"terraform/${TF_VAR_environment}/\"
  }
}"

# Terraform initialize should run on env folder.
cd "${ROOT}/env"
echo -e "${backend_config}" > backend.tf

# Terraform initinalize the backend bucket
terraform init -input=false

# Create workspace based on the environment, by doing this you don't overlap wih the resources in different environments.
terraform workspace new "$TF_VAR_environment" || terraform workspace select "$TF_VAR_environment"

#make validate : this command will validate the terraform code
terraform validate

# Functions Script to enable google api's
source "${ROOT}/scripts/enable.sh"
