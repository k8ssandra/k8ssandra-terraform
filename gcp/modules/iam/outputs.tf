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

# Output variable for the service account email.
output "service_account" {
  description = "Service Account Email-id"
  value       = google_service_account.service_account.email
}

# Output variable for the service account key.
output "service_account_key" {
  description = "The service Account Key to configure Medusa backups to use GCS bucket"
  value       = base64decode(google_service_account_key.service_account_key.private_key)
  sensitive   = true
}
