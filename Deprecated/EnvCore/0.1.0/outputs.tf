output "gke-endpoints" {
  value = module.gke.endpoint
}

output "gke-ca-certificate" {
  value = module.gke.ca_certificate
}