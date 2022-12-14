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

data "google_storage_bucket_object_content" "GKE-API-TW" {
  bucket = local.ProjectName
  name   = local.GKE-API-TW
}

data "google_storage_bucket_object_content" "GKE-CA-TW" {
  bucket = local.ProjectName
  name   = local.GKE-CA-TW
}

provider "kubernetes" {
  alias = "tw"
  host = "https://${data.google_storage_bucket_object_content.GKE-API-TW.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-TW.content)
}

# permission: Storage Object Viewer
data "google_storage_bucket_object_content" "GKE-API-EU" {
  bucket = local.ProjectName
  name   = local.GKE-API-EU
}

data "google_storage_bucket_object_content" "GKE-CA-EU" {
  bucket = local.ProjectName
  name   = local.GKE-CA-EU
}

provider "kubernetes" {
  alias = "eu"
  host = "https://${data.google_storage_bucket_object_content.GKE-API-EU.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-EU.content)
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.GKE-API-TW.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-TW.content)
  }
}