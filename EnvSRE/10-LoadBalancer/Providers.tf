﻿# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = var.GCPRegion   # assign default value.
  zone    = var.GCPZone     # assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-lb.json")
}

data "google_client_config" "default" {}

# permission: Storage Object Viewer
data "google_storage_bucket_object_content" "GKE-API-London" {
  bucket = local.ProjectName
  name   = local.GKE-API-London
}

data "google_storage_bucket_object_content" "GKE-CA-London" {
  bucket = local.ProjectName
  name   = local.GKE-CA-London
}

provider "kubernetes" {
  alias = "london"
  host = "https://${data.google_storage_bucket_object_content.GKE-API-London.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-London.content)
}

# permission: Storage Object Viewer
data "google_storage_bucket_object_content" "GKE-API-Singapore" {
  bucket = local.ProjectName
  name   = local.GKE-API-Singapore
}

data "google_storage_bucket_object_content" "GKE-CA-Singapore" {
  bucket = local.ProjectName
  name   = local.GKE-CA-Singapore
}

provider "kubernetes" {
  alias = "singapore"
  host = "https://${data.google_storage_bucket_object_content.GKE-API-Singapore.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-Singapore.content)
}

# permission: Storage Object Viewer
data "google_storage_bucket_object_content" "GKE-API-LosAngeles" {
  bucket = local.ProjectName
  name   = local.GKE-API-LosAngeles
}

data "google_storage_bucket_object_content" "GKE-CA-LosAngeles" {
  bucket = local.ProjectName
  name   = local.GKE-CA-LosAngeles
}

provider "kubernetes" {
  alias = "la"
  host = "https://${data.google_storage_bucket_object_content.GKE-API-LosAngeles.content}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-LosAngeles.content)
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.GKE-API-Singapore.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.GKE-CA-Singapore.content)
  }
}
