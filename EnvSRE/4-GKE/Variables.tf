#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]
  
  GKE-API-AsiaTaiwanDev = local.Settings["GKE"]["AsiaTaiwanDev"]["APIName"]
  GKE-CA-AsiaTaiwanDev = local.Settings["GKE"]["AsiaTaiwanDev"]["CAName"]
#  GKE-API-AsiaTaiwanRelease = local.Settings["GKE"]["AsiaTaiwanRelease"]["APIName"]
#  GKE-CA-AsiaTaiwanRelease = local.Settings["GKE"]["AsiaTaiwanRelease"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = "asia-east1"
  GCPZone = "asia-east1-c"
}

