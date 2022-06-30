data "kubernetes_service" "battle" {
  metadata {
    name = "battle"
    namespace = "battle"
  }
}

# require permission: Storage Admin
resource "google_storage_bucket_object" "NEG-Battle" {
  bucket  = var.ProjectName
  name    = "NEGBattleName-${var.GCPZone}"
  content = jsondecode(data.kubernetes_service.battle.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
}

data "kubernetes_service" "file" {
  metadata {
    name = "file"
    namespace = "file"
  }
}

# require permission: Storage Admin
resource "google_storage_bucket_object" "NEG-File" {
  bucket  = var.ProjectName
  name    = "NEGFileName-${var.GCPZone}"
  content = jsondecode(data.kubernetes_service.file.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
}
