# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-TW" {
  source = "../../Modules/GKE-Safe/0.4.0/"

  ProjectName = local.ProjectName

  UniqueName = "tw-dev"

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone
  GKE-Zones    = [local.GCPZone]
  GKE-Labels   = { "name" = "sre" }

  GKE-ControlPlaneCIDR   = "10.0.0.0/28"
  GKE-NodeSizeGB = 30
  GKE-CheapNodePool-2C8G = true
  GKE-NodePoolScale-2C8G = false
  GKE-MaxNum-2C8G        = 0
  GKE-NodeNum-2C8G       = 0

  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 2
  GKE-NodeNum-4C16G       = 2

  GKE-APIName = local.GKE-API-TW
  GKE-CAName  = local.GKE-CA-TW
}

#module "GKE-Rel" {
#  source  = "../../Modules/GKE/0.2.0"
#
#  ProjectName = local.ProjectName
#
#  GCPProjectID = local.ProjectID
#  GCPRegion = local.GCPRegion
#  GCPZone = "asia-east1-b"
#  GKE-Zones = ["asia-east1-b"]
#
#  GKE-EnableScale-e2-standard-2 = false
#  GKE-NodeCount-e2-standard-2 = 0
#  GKE-EnableScale-e2-standard-4 = false
#  GKE-NodeCount-e2-standard-4 = 1
#  GKE-MaxCount-e2-standard-2 = 1
#  GKE-MaxCount-e2-standard-4 = 1
#
#  GKE-APIName = local.GKE-API-TW-Rel
#  GKE-CAName  = local.GKE-CA-TW-Rel
#}
