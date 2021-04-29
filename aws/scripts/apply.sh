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

# Run common.sh script for variable declaration and validation
source "${ROOT}/scripts/common.sh"

# Make apply : this command will apply the infrastructure changes
(cd "${ROOT}/env"; terraform apply -input=false -auto-approve)

# Get cluster outputs from the cluster.
GET_OUTPUTS="$(terraform output endpoint)"
${GET_OUTPUTS}

# Clone k8ssandra repo
git clone https://github.com/k8ssandra/k8ssandra.git
cd k8ssandra 

# Call the existing script to run the E2E testing on the cluster.
make integ-test
