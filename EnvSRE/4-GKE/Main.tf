# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-TW" {
  source = "../../Modules/GKE-Safe/1.0.0"

  ProjectName = local.ProjectName

  UniqueName = "tw-test"

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone
  GKE-Zones    = [local.GCPZone]
  GKE-Labels   = { "location" = "asia-taiwan", "environment" = "test" }

  GKE-ControlPlaneCIDR     = "10.0.0.0/28"
  GKE-CreateServiceAccount = true

  GKE-NodeSizeGB         = 30
  GKE-CheapNodePool-2C8G = true
  GKE-NodePoolScale-2C8G = false
  GKE-MaxNum-2C8G        = 0
  GKE-NodeNum-2C8G       = 0

  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 2
  GKE-NodeNum-4C16G       = 2

  GKE-APIName = local.GKE-API-TaiwanDev
  GKE-CAName  = local.GKE-CA-TaiwanDev
  
  CloudSQLProxy_Enabled = true
  CloudSQLProxy_EnableNetworkPolicy = true
}


