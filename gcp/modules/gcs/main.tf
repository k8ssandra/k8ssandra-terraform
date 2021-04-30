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


# Google storage bucket with standared storage class
resource "google_storage_bucket" "storage_bucket" {
  name                        = var.name
  project                     = var.project_id
  location                    = var.region
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.bucket_policy_only
  force_destroy               = true

}

# Google Storage bucket IAM member resource
resource "google_storage_bucket_iam_member" "storage_bucket_iam_member" {
  bucket = google_storage_bucket.storage_bucket.name
  role   = "roles/storage.admin"
  member = format("serviceAccount:%s", var.service_account)
}
