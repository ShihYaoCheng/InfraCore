# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source  = "../../Modules/GKE/0.1.0"

  ProjectName = "cqi-sk-dev"
  
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  GKE-Zones = ["asia-east1-a"]
  
  GKE-EnableScale-e2-standard-2 = false
  GKE-NodeCount-e2-standard-2 = 0
  GKE-NodeCount-e2-standard-4 = 1
}

