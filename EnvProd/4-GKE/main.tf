# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-TW" {
  source = "../../Modules/GKE-Safe/0.6.0"

  ProjectName = local.ProjectName
  UniqueName  = "tw"

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone
  GKE-Zones    = [local.GCPZone]

  GKE-APIName = local.GKE-API-TW
  GKE-CAName  = local.GKE-CA-TW

  GKE-CreateServiceAccount = true

  GKE-NodeSizeGB          = 80
  GKE-CheapNodePool-2C8G  = true
  GKE-NodePoolScale-2C8G  = false
  GKE-MaxNum-2C8G         = 0
  GKE-NodeNum-2C8G        = 0
  
  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 2
  GKE-NodeNum-4C16G       = 2

  GKE-ControlPlaneCIDR = "10.0.0.0/28"
}

