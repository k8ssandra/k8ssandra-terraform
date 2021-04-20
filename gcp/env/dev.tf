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

# Create google compute network(VPC).
module "vpc" {
  source      = "../modules/vpc"
  name        = local.prefix
  environment = var.environment
  region      = var.region
  project_id  = var.project_id
}

# Create GKE cluster.
module "gke" {
  source          = "../modules/gke"
  environment     = var.environment
  name            = local.prefix
  region          = var.region
  project_id      = var.project_id
  network_link    = module.vpc.network_selflink
  subnetwork_link = module.vpc.subnetwork_selflink
  service_account = module.iam.service_account
}

# Create Service Account and IAM roles in GCP.
module "iam" {
  source                           = "../modules/iam"
  name                             = local.prefix
  region                           = var.region
  project_id                       = var.project_id
  service_account_custom_iam_roles = var.service_account_custom_iam_roles
  service_account_iam_roles        = var.service_account_iam_roles
  project_services                 = var.project_services
}

# Create GCS bucket
module "gcs" {
  source          = "../modules/gcs"
  name            = format("%s-storage-bucket", local.prefix)
  environment     = var.environment
  region          = var.region
  project_id      = var.project_id
  service_account = module.iam.service_account
}
