# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.GCPProjectID // assign default value.
  region  = var.GCPRegion    // assign default value.
  zone    = var.GCPZone      // assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-cloudrun.json")
}



