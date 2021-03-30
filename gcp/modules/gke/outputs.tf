output "endpoint" {
  value = google_container_cluster.container_cluster.endpoint
}

output "master_version" {
  value = google_container_cluster.container_cluster.master_version
}
