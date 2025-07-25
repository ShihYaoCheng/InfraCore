﻿module "GKE-TW-Dev" {
  source = "../../Modules/GKE-Safe/1.1.0"

  ProjectName = local.ProjectName
  UniqueName  = "TW-Dev"

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = "asia-east1-a"
  GKE-Zones    = ["asia-east1-a"]
  GKE-Labels   = { "location" = "tw", "env" = "dev" }

  GKE-ControlPlaneCIDR     = "10.0.0.0/28"
  GKE-APIName              = local.GKE-API-TW-Dev
  GKE-CAName               = local.GKE-CA-TW-Dev
  GKE-CreateServiceAccount = true

  GKE-NodeSizeGB         = 70
  GKE-CheapNodePool-2C8G = true
  GKE-NodePoolScale-2C8G = false
  GKE-MaxNum-2C8G        = 3
  GKE-NodeNum-2C8G       = 3

  GKE-CheapNodePool-4C16G = true
  GKE-NodePoolScale-4C16G = false
  GKE-MaxNum-4C16G        = 0
  GKE-NodeNum-4C16G       = 0

  CloudSQLProxy_Enabled             = true
  CloudSQLProxy_EnableNetworkPolicy = true
}



