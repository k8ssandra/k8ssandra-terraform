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

# Make will use bash instead of sh
# Export the required environment variables before using the make command. 
SHELL := /usr/bin/env bash
ROOT := ${CURDIR}

.PHONY: help
help:
	@echo 'Usage:'
	@echo '    make init	Initialize and configure Backend.'
	@echo '    make plan	Plan all GCP resources.'
	@echo '    make apply	Create or update GCP resources.'
	@echo '    make destroy   Destroy all GCP resources.'
	@echo '    make validate   Check that installed resources work as expected.'
	@echo '    make lint       Check syntax of all scripts.'
	@echo '    make get pods	Get running pods IP's and Namespaces run this command after apply'
	@echo

# Before you run this command please export the required variables.
# Initialize the environment variables 
.PHONY: init
init:
	bash $(ROOT)/scripts/init.sh

# Plan the google cloud resources
.PHONY: plan
plan:
	bash $(ROOT)/scripts/plan.sh

# Apply the google cloud resources
.PHONY: apply
apply:
	bash $(ROOT)/scripts/apply.sh

# Destroy the terraform resources
.PHONY: destroy
destroy:
	bash $(ROOT)/scripts/destroy.sh

# Validate terraform resources
.PHONY: validate
validate:
	bash ${ROOT}/scripts/validate.sh

# Get pods details of	 the running container cluster.
.PHONY: get pods
get pods:
	python ${ROOT}/test/kube-pods.py

.PHONY: lint
lint: Check_shell check_terraform check_shebangs check_trailing_whitespace

# Shell check
.PHONY: check_shell
check_shell:
	source ${ROOT}/test/lint.sh && check_shell

# Terraform check
.PHONY: check_terraform
check_terraform:
	source ${ROOT}/test/lint.sh && check_terraform

# Shebangs check
.PHONY: check_shebangs
check_shebangs:
	source ${ROOT}/test/lint.sh && check_bash

# Check trailing whitespace
.PHONY: check_trailing_whitespace
check_trailing_whitespace:
	source ${ROOT}/test/lint.sh && check_trailing_whitespace
