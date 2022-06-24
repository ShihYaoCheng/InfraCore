# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-US" {
  source  = "../../Modules/GKE/0.1.0"

  ProjectName = file("../ProjectName.txt")

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  GKE-Zones = [var.GCPZone]
  
  GKE-EnableScale-e2-standard-2 = false
  GKE-NodeCount-e2-standard-2 = 1
  GKE-NodeCount-e2-standard-4 = 0
}

