﻿# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "GKE-LosAngeles" {
  source = "../../Modules/GKE-Safe/1.0.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone

  UniqueName = "la"

  GKE-ControlPlaneCIDR     = "10.0.0.48/28"
  GKE-CreateServiceAccount = true

  GKE-Zones   = [local.GCPZone]
  GKE-Labels   = { "location" = "la", "env" = "qa" }
  GKE-APIName = local.GKE-API
  GKE-CAName  = local.GKE-CA

  GKE-NodeSizeGB          = 70
  GKE-CheapNodePool-2C8G  = true
  GKE-NodePoolScale-2C8G  = false
  GKE-MaxNum-2C8G         = 3
  GKE-NodeNum-2C8G        = 3
  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 0
  GKE-NodeNum-4C16G       = 0

  CloudSQLProxy_Enabled = false
  CloudSQLProxy_EnableNetworkPolicy = false
}

