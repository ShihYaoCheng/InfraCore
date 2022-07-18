# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = local.ProjectID  # assign default value.
  region  = local.GCPRegion    # assign default value.
  zone    = local.GCPZone      # assign default value.
  credentials = file("../../../keys/dev-gitlab-sk-infra-gke.json")
}
