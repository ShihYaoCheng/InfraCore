terraform {
  backend "http" {}
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = local.GCPRegion   # assign default value.
  zone    = local.GCPZone     # assign default value.
}

data "google_client_config" "default" {}

data "google_storage_bucket_object_content" "GKE-API" {
  bucket = local.ProjectName
  name   = local.GKE-API-London
}

data "google_storage_bucket_object_content" "GKE-CA" {
  bucket = local.ProjectName
  name   = local.GKE-CA-London
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

