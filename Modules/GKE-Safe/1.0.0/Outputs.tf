output "API-Endpoint" {
  value = module.GKE-PrivateCluster.endpoint
}

output "CA-Certificate" {
  value = module.GKE-PrivateCluster.ca_certificate
}