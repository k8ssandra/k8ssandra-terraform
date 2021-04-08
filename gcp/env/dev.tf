# copyright 2020 Datastax LLC
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

# Module call for creating google compute network
module "vpc" {
  source           = "../modules/vpc"
  name             = local.prefix
  region           = var.region
  project_id       = var.project_id
  project_services = var.project_services
}

# Module call to create gke cluster
module "gke" {
  source          = "../modules/gke"
  name            = local.prefix
  region          = var.region
  project_id      = var.project_id
  network_link    = module.vpc.network_selflink
  subnetwork_link = module.vpc.subnetwork_selflink
  service_account = module.iam.service_account
}

# Module call to create service account and roles
module "iam" {
  source                           = "../modules/iam"
  name                             = local.prefix
  region                           = var.region
  project_id                       = var.project_id
  service_account_custom_iam_roles = var.service_account_custom_iam_roles
  service_account_iam_roles        = var.service_account_iam_roles
}

# Module call to create google cloud storage bucket
module "gcs" {
  source          = "../modules/gcs"
  name            = format("%s-storage-bucket", local.prefix)
  region          = var.region
  project_id      = var.project_id
  service_account = module.iam.service_account
}
