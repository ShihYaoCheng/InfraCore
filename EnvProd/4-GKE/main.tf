# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source = "../../Modules/GKE/0.2.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone
  GKE-Zones    = [local.GCPZone]

  GKE-EnableScale-e2-standard-2 = false
  GKE-MaxCount-e2-standard-2    = 0
  GKE-NodeCount-e2-standard-2   = 0
  GKE-EnableScale-e2-standard-4 = true
  GKE-MaxCount-e2-standard-4    = 2
  GKE-NodeCount-e2-standard-4   = 1

  GKE-APIName = local.GKE-API-TW
  GKE-CAName  = local.GKE-CA-TW
}

