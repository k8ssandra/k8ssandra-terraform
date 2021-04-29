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

# Output attributes of the S3 bucket
# AWS s3 bucket id
output "bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "Bucket Name (aka ID)"
}

# AWS s3 bucket arn
output "bucket_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "The arn of the bucket will be in format arn:aws:s3::bucketname"
}
