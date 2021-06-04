#!/usr/bin/env bash
# shellcheck disable=SC1091

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

# Run common.sh script for variable declaration and validation
source "${ROOT}/scripts/common.sh"

#make plan : this command will validate the terraform code
cd "${ROOT}"/env

# Terraform validate before the plan
terraform validate

# Terraform plan will create a plan file in your current repository. Verify the all the resource it create by using plan. 
terraform plan -no-color
