# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-US" {
  source  = "../../Modules/GKE/0.2.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
  GCPZone = local.GCPZone
  GKE-Zones = [local.GCPZone]
  
  GKE-EnableScale-e2-standard-2 = true
  GKE-MaxCount-e2-standard-2 = 2
  GKE-NodeCount-e2-standard-2 = 1
  GKE-EnableScale-e2-standard-4 = false
  GKE-MaxCount-e2-standard-4 = 1
  GKE-NodeCount-e2-standard-4 = 0

  GKE-APIName = local.GKE-API-EU
  GKE-CAName  = local.GKE-CA-EU
}

