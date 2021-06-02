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


# Common commands for all scripts              

# Locate the root directory. Used by scripts that source this one.
# shellcheck disable=SC2034
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# git is required for this tutorial
# https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
command -v git >/dev/null 2>&1 || { \
 echo >&2 "I require git but it's not installed.  Aborting."
 echo >&2 "Refer to: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
 exit 1
}

# aws cliv2 is required for this tutorial
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
command -v aws >/dev/null 2>&1 || { \
 echo >&2 "I require aws cliv2 but it's not installed.  Aborting."
 echo >&2 "Refer to: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html"
 exit 1
}

# Make sure kubectl is installed.  If not, refer to:
# https://kubernetes.io/docs/tasks/tools/install-kubectl/
command -v kubectl >/dev/null 2>&1 || { \
 echo >&2 "I require kubectl but it's not installed.  Aborting."
 echo >&2 "Refer to: https://kubernetes.io/docs/tasks/tools/install-kubectl/"
 exit 1
}

# Make sure Helm is installed. If not, refer to:
# https://helm.sh/docs/intro/install/
command -v helm >/dev/null 2>&1 || { \
 echo >&2 "I require helm but it's not installed.  Aborting."
 echo >&2 "Refer to: https://helm.sh/docs/intro/install/"
 exit 1
}

# Make sure Terraform 0.14 or higer versions installed. If not, refer to:
# https://www.terraform.io/docs/cli/install/apt.html
command -v terraform >/dev/null 2>&1 || { \
 echo >&2 "I require terraform 0.14 or higher version but it's not installed.  Aborting."
 echo >&2 "https://www.terraform.io/docs/cli/install/apt.html"
 echo >&2 "Refer to: sudo apt install terraform=0.14.0"
 exit 1
}

# Make sure python3 is installed. If not, refer to:
# https://www.python.org/downloads/
command -v python3 >/dev/null 2>&1 || { \
 echo >&2 "I require python3 but it's not installed.  Aborting."
 echo >&2 "https://www.python.org/downloads/"
 exit 1
}

# Make sure pip3 is installed. if not, refer to:
# run this command to install : sudo apt-get -y install python3-pip
command -V pip3 >/dev/null 2>&1 || { \
 echo >&2 "I require pip3 but it's not installed.  Aborting."
 echo >&2 "sudo apt-get -y install python3-pip"
 exit 1
}

# Make sure you initialize the following TF_VAR's before you initialize the environment
if [ -z "${TF_VAR_environment}" ] || [ -z "${TF_VAR_name}" ] || [ -z "${TF_VAR_region}" ]; then
  printf "This step requires to export the the following variables \nTF_VAR_environment: %s \nTF_VAR_name: %s \nTF_VAR_region: %s" "${TF_VAR_environment}" "${TF_VAR_name}" "${TF_VAR_region}"
  exit 1
else 
  printf "Following variables are configured \nTF_VAR_environment: %s \nTF_VAR_name: %s \nTF_VAR_region: %s" "${TF_VAR_environment}" "${TF_VAR_name}" "${TF_VAR_region}"
fi

# Simple test helpers that avoids eval and complex quoting. Note that stderr is
# redirected to stdout so we can properly handle output.
# Usage: test_des "description"
test_des() {
  echo -n "Checking that $1... "
}

# Usage: test_cmd "$(command string 2>&1)"
test_cmd() {
  local result=$?
  local output="$1"

  # If command completes successfully, output "pass" and continue.
  if [[ $result == 0 ]]; then
    echo "pass"

  # If ccommand fails, output the error code, command output and exit.
  else
    echo -e "fail ($result)\\n"
    cat <<<"$output"
    exit $result
  fi
}
