#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]
  
  GKE-API-TaiwanDev = local.Settings["GKE"]["TaiwanDev"]["APIName"]
  GKE-CA-TaiwanDev = local.Settings["GKE"]["TaiwanDev"]["CAName"]
#  GKE-API-AsiaTaiwanRelease = local.Settings["GKE"]["AsiaTaiwanRelease"]["APIName"]
#  GKE-CA-AsiaTaiwanRelease = local.Settings["GKE"]["AsiaTaiwanRelease"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["Taiwan"]["Region"]
  GCPZone = local.Settings["Project"]["Taiwan"]["Zone"]
}

