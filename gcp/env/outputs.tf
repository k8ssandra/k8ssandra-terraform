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

# gke module output attributes
#------------------------------
# Print GKE cluster endpoint.
output "endpoint" {
  value = module.gke.endpoint
}

# Print GKE cluster version.
output "master_version" {
  value = module.gke.master_version
}

# gcs module output attributes
#-----------------------------
output "bucket_name" {
  value = module.gcs.bucket_name
}

# Google cloud service account
#-----------------------------
output "service_account" {
  value = module.iam.service_account
}

output "service_account_key" {
  value = module.iam.service_account_key
}
