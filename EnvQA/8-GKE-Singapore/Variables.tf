#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-London = local.Settings["GKE"]["London"]["APIName"]
  GKE-CA-London = local.Settings["GKE"]["London"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["London"]["Region"]
  GCPZone = local.Settings["Project"]["London"]["Zone"]
}


