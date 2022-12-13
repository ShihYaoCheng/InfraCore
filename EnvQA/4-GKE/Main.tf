# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-TW" {
  source = "../../Modules/GKE-Safe/1.0.0"

  ProjectName = local.ProjectName
  UniqueName = "tw"

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone
  GKE-Zones    = [local.GCPZone]
  GKE-Labels   = { "location" = "taiwan", "environment" = "qa" }

  GKE-ControlPlaneCIDR     = "10.0.0.0/28"
  GKE-CreateServiceAccount = true

  GKE-NodeSizeGB          = 70
  GKE-CheapNodePool-2C8G  = true
  GKE-NodePoolScale-2C8G  = false
  GKE-MaxNum-2C8G         = 3
  GKE-NodeNum-2C8G        = 3
  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 0
  GKE-NodeNum-4C16G       = 0

  GKE-APIName = local.GKE-API-Taiwan
  GKE-CAName  = local.GKE-CA-Taiwan

  CloudSQLProxy_Enabled = true
  CloudSQLProxy_EnableNetworkPolicy = true
}


