terraform {
  # https://github.com/VladRassokhin/intellij-hcl/issues/365#issuecomment-996019841
  # https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
  required_version = ">1.0.8"

  backend "http" {}

  required_providers {
    // https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      #      version = "~>3.90.1"
      version = "~>4.12.0"
    }

    // https://registry.terraform.io/providers/hashicorp/helm/latest
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.4.1"
    }

    # https://registry.terraform.io/providers/hashicorp/random/latest
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "random" {
  # Configuration options
}

// https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion     // assign default value.
  zone    = var.GCPZone       // assign default value.
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
