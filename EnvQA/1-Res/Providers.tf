terraform {
  backend "http" {}
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
}

provider "google-beta" {
  project = local.ProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
}