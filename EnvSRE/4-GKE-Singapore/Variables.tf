#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]
  
  GKE-API = local.Settings["GKE"]["Singapore"]["APIName"]
  GKE-CA = local.Settings["GKE"]["Singapore"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["Singapore"]["Region"]
  GCPZone = local.Settings["Project"]["Singapore"]["Zone"]
}

