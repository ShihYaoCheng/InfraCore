terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
#  required_version = "~> 1.0.11"

  backend "http" {}

#  required_providers {
#    // https://registry.terraform.io/providers/hashicorp/google/latest
#    google = {
#      source = "hashicorp/google"
#      version = "~>4.16.0"
#    }
#
#    // https://registry.terraform.io/providers/hashicorp/helm/latest
#    helm = {
#      source  = "hashicorp/helm"
#      version = "~>2.5.0"
#    }
#  }
}

// https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
}

data "google_client_config" "default" {}

data "google_storage_bucket_object_content" "GKE-API" {
  bucket = var.ProjectName
  name   = "GKE.api"
}

data "google_storage_bucket_object_content" "GKE-CA" {
  bucket = var.ProjectName
  name   = "GKE.ca"
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