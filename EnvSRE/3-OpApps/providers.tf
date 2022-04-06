terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  # https://www.terraform.io/language/expressions/version-constraints
  required_version = "~> 1.0.11"

  required_providers {
    // https://registry.terraform.io/providers/hashicorp/helm/latest
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.5.0"
    }
  }
}

data "google_client_config" "default" {}

data "google_storage_bucket_object_content" "api" {
  name   = "api"
  bucket = "sk-sre"
}

data "google_storage_bucket_object_content" "ca" {
  bucket = "sk-sre"
  name   = "ca"
}

provider "helm" {
  debug = true

  kubernetes {
    host                   = "https://${data.google_storage_bucket_object_content.api.content}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_storage_bucket_object_content.ca.content)
  }
}
