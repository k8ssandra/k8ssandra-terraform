output "network_selflink" {
  value = google_compute_network.compute_network.self_link
}

output "subnetwork_selflink" {
  value = google_compute_subnetwork.compute_subnetwork.self_link
}
