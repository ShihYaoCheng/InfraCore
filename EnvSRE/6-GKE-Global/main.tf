# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-EU" {
  source = "../../Modules/GKE-Safe/1.0.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone

  UniqueName = "eu-test"

  GKE-ControlPlaneCIDR     = "10.0.0.16/28"
  GKE-CreateServiceAccount = true

  GKE-Zones   = [local.GCPZone]
  GKE-Labels   = { "location" = "eu", "environment" = "test" }
  GKE-APIName = local.GKE-API-EU
  GKE-CAName  = local.GKE-CA-EU

  GKE-NodeSizeGB         = 30
  GKE-CheapNodePool-2C8G = true
  GKE-NodePoolScale-2C8G = false
  GKE-MaxNum-2C8G        = 0
  GKE-NodeNum-2C8G       = 0

  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 2
  GKE-NodeNum-4C16G       = 2

  CloudSQL_Enabled = false
}

