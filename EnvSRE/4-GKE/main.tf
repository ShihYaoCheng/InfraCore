# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source  = "../../Modules/GKE/0.1.0"

  ProjectName = var.ProjectName

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  GKE-Zones = ["asia-east1-a"]
}

