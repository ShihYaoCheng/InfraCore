resource "google_storage_bucket_object" "GKE-API" {
  bucket  = var.ProjectName
  name    = "GKE-${var.GCPRegion}.api"
  content = module.gke.endpoint
}

resource "google_storage_bucket_object" "GKE-CA" {
  bucket  = var.ProjectName
  name    = "GKE-${var.GCPRegion}.ca"
  content = module.gke.ca_certificate
}