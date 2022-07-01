# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE" {
  source  = "../../Modules/GKE/0.1.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  GKE-Zones = [var.GCPZone]

  GKE-EnableScale-e2-standard-2 = false
  GKE-NodeCount-e2-standard-2 = 0
  GKE-EnableScale-e2-standard-4 = false
  GKE-NodeCount-e2-standard-4 = 1
}

