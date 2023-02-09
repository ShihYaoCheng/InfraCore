# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-London" {
  source = "../../Modules/GKE-Safe/1.1.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone

  UniqueName = "london-test"

  GKE-ControlPlaneCIDR     = "10.0.0.16/28"
  GKE-CreateServiceAccount = true

  GKE-Zones   = [local.GCPZone]
  GKE-Labels   = { "location" = "london", "environment" = "test" }
  GKE-APIName = local.GKE-API-London
  GKE-CAName  = local.GKE-CA-London

  GKE-NodeSizeGB         = 30
  GKE-CheapNodePool-2C8G = true
  GKE-NodePoolScale-2C8G = false
  GKE-MaxNum-2C8G        = 0
  GKE-NodeNum-2C8G       = 0

  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 2
  GKE-NodeNum-4C16G       = 2

  CloudSQLProxy_Enabled = false
  CloudSQLProxy_EnableNetworkPolicy = false
}

