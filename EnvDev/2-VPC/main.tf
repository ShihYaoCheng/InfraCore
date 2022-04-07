
# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~>5.0.0"

  project_id   = var.GCPProjectID
  network_name = "sk-dev"

  auto_create_subnetworks = true

  # https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits
  # https://cidr.xyz/
  subnets = []
}

