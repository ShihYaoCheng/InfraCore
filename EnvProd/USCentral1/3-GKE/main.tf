# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source  = "../../../Modules/GKE/0.1.0"

  ProjectName = "cqi-sk-prod-us-central1"
  GKE-VPCName = "cqi-sk-prod"
  GKE-Zones = ["us-central1-c"]

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
}

