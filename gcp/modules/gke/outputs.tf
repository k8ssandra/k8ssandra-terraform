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

# End point of the google container cluster.
output "endpoint" {
  description = "End point of the google container cluster"
  value       = google_container_cluster.container_cluster.endpoint
}

# Master version of Kubernetes cluster.
output "master_version" {
  description = "Master version of Kubernetes cluster"
  value       = google_container_cluster.container_cluster.master_version
}

# GKE cluster name.
output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.container_cluster.name
}
