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

# Output attibutes of the iam resources.
# AWS Iam role arn.
output "role_arn" {
  description = "IAM role for EKS service."
  value       = aws_iam_role.iam_role.arn
}

# AWS Iam worker role arn.
output "worker_role_arn" {
  description = "IAM role arn for EKS worker nodes."
  value       = aws_iam_role.worker_iam_role.arn
}

# AWS Iam instace profile id.
output "iam_instance_profile" {
  description = "IAM instance profile for the EKS worker nodes."
  value       = aws_iam_instance_profile.iam_instance_profile.id
}
