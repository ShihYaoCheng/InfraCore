terraform {
  required_version = ">= 1.0.0"

  backend "http" {}

  required_providers {
    // https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "~>3.89.0"
    }

    // https://registry.terraform.io/providers/hashicorp/helm/latest
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.4.1"
      //      version = "1.3.2"
    }
  }
}

// https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.project-id // assign default value.
  region  = var.region     // assign default value.
  zone    = var.zone       // assign default value.
}

data "google_client_config" "default" {}

provider "helm" {
  debug = true

  kubernetes {
    host                   = "https://${module.infra.gke-endpoints}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.infra.gke-ca-certificate)
  }
}

#provider "kubectl" {
#  load_config_file       = false
#  host                   = "https://${module.infra.gke-endpoints}"
#  token                  = data.google_client_config.default.access_token
#  cluster_ca_certificate = base64decode(module.infra.gke-ca-certificate)
#}