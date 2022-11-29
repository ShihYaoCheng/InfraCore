terraform {
  backend "http" {}
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = local.GCPRegion # assign default value.
  zone    = local.GCPZone   # assign default value.
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = "https://${module.GKE-TW.API-Endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.GKE-TW.CA-Certificate)
  }
}

provider "kubernetes" {
  host = "https://${module.GKE-TW.API-Endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.GKE-TW.CA-Certificate)
}

