output "endpoint" {
  value = module.first_gke_cluster.endpoint
}

output "master_version" {
  value = module.first_gke_cluster.master_version
}
