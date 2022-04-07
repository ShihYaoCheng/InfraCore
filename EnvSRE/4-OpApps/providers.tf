terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
  required_version = "~> 1.0.11"

  required_providers {
    // https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source = "hashicorp/google"
      version = "~>4.16.0"
    }

    // https://registry.terraform.io/providers/hashicorp/helm/latest
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.5.0"
    }
  }
}

// https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
  credentials = file("../../../keys/gitlab-sk-infra-op.json")
}

data "google_client_config" "default" {}

data "google_storage_bucket_object_content" "gke-name" {
  bucket = local.GCSBucketName
  name   = "GKEName"
}

data "google_storage_bucket_object_content" "gke-api" {
  bucket = local.GCSBucketName
  name   = "${data.google_storage_bucket_object_content.gke-name.content}.api"
}

data "google_storage_bucket_object_content" "gke-ca" {
  bucket = local.GCSBucketName
  name   = "${data.google_storage_bucket_object_content.gke-name.content}.ca"
}

provider "helm" {
  debug = true

  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.gke-api.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.gke-ca.content)
  }
}
