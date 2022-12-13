# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID # assign default value.
  region  = local.GCPRegion # assign default value.
  zone    = local.GCPZone   # assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-gke.json")
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = "https://${module.GKE-London.API-Endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.GKE-London.CA-Certificate)
  }
}

provider "kubernetes" {
  host = "https://${module.GKE-London.API-Endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.GKE-London.CA-Certificate)
}