# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-apps.json")
}

data "google_client_config" "default" {}

data "google_storage_bucket_object_content" "GKE-API" {
  bucket = local.ProjectName
  name   = local.GKE-API-TW
}

data "google_storage_bucket_object_content" "GKE-CA" {
  bucket = local.ProjectName
  name   = local.GKE-CA-TW
}

provider "helm" {
  alias = "dev"
  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.GKE-API.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA.content)
  }
}

provider "kubernetes" {
  alias = "dev"
  host = "https://${data.google_storage_bucket_object_content.GKE-API.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA.content)
}



data "google_storage_bucket_object_content" "GKE-API-Rel" {
  bucket = local.ProjectName
  name   = local.GKE-API-TW-Rel
}

data "google_storage_bucket_object_content" "GKE-CA-Rel" {
  bucket = local.ProjectName
  name   = local.GKE-CA-TW-Rel
}

provider "helm" {
  alias = "rel"
  
  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.GKE-API-Rel.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-Rel.content)
  }
}

provider "kubernetes" {
  alias = "rel"
  host = "https://${data.google_storage_bucket_object_content.GKE-API-Rel.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-Rel.content)
}

