# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-apps.json")
}

data "google_client_config" "default" {}

data "google_storage_bucket_object_content" "GKE-API" {
  bucket = var.ProjectName
  name   = "GKE-${var.GCPRegion}.api"
}

data "google_storage_bucket_object_content" "GKE-CA" {
  bucket = var.ProjectName
  name   = "GKE-${var.GCPRegion}.ca"
}

provider "helm" {
  debug = true

  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.GKE-API.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA.content)
  }
}

provider "kubernetes" {
  host = "https://${data.google_storage_bucket_object_content.GKE-API.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA.content)
}

