module "GKE-TW-Dev" {
  source  = "../../Modules/GKE/0.2.0"

  ProjectName = local.ProjectName
  
  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
  GCPZone = "asia-east1-a"
  GKE-Zones = ["asia-east1-a"]
  
  GKE-EnableScale-e2-standard-2 = false
  GKE-MaxCount-e2-standard-2 = 1
  GKE-NodeCount-e2-standard-2 = 0
  GKE-EnableScale-e2-standard-4 = false
  GKE-MaxCount-e2-standard-4 = 1
  GKE-NodeCount-e2-standard-4 = 1

  GKE-APIName = local.GKE-API-TW-Dev
  GKE-CAName  = local.GKE-CA-TW-Dev
}

module "GKE-TW-Rel" {
  source  = "../../Modules/GKE/0.2.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
  GCPZone = "asia-east1-b"
  GKE-Zones = ["asia-east1-b"]

  GKE-EnableScale-e2-standard-2 = false
  GKE-MaxCount-e2-standard-2 = 1
  GKE-NodeCount-e2-standard-2 = 0
  GKE-EnableScale-e2-standard-4 = false
  GKE-MaxCount-e2-standard-4 = 1
  GKE-NodeCount-e2-standard-4 = 1

  GKE-APIName = local.GKE-API-TW-Rel
  GKE-CAName  = local.GKE-CA-TW-Rel
}

