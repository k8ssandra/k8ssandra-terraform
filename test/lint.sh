#!/usr/bin/env bash

# Copyright 2021 Datastax LLC
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

set -ex
# This function checks to make sure that every
# shebang has a '- e' flag, which causes it
# to exit on error

function check_bash() {
find . -name "*.sh" | while IFS= read -d '' -r file;
do
  if [[ "$file" != *"bash -e"* ]];
  then
    echo "$file is missing shebang with -e";
    exit 1;
  fi;
done;
}

# This function runs 'terraform validate' against all
# files ending in '.tf'
function check_terraform() {
  echo "Running terraform validate"
  REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
  cd "${REPO_ROOT}/gcp/env/" || exit
  terraform init
  terraform validate
}

# This function runs the shellcheck linter on every
# file ending in '.sh'
function check_shell() {
  echo "Running shellcheck"
  find . -name "*.sh" -exec shellcheck -x {} \;
}

# This function makes sure that there is no trailing whitespace
# in any files in the project.
# There are some exclusions
function check_trailing_whitespace() {
  echo "The following lines have trailing whitespace"
  grep -r '[[:blank:]]$' --exclude-dir=".terraform" --exclude="*.png" --exclude-dir=".git" --exclude="*.md" .
  rc=$?
  if [ $rc = 0 ]; then
    exit 1
  fi
}
