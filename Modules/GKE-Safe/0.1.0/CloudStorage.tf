resource "google_storage_bucket_object" "GKE-API" {
  bucket  = var.ProjectName
  name    = var.GKE-APIName
  content = module.GKE-SafeCluster.endpoint
}

resource "google_storage_bucket_object" "GKE-CA" {
  bucket  = var.ProjectName
  name    = var.GKE-CAName
  content = module.GKE-SafeCluster.ca_certificate
}