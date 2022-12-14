#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-Taiwan = local.Settings["GKE"]["Taiwan"]["APIName"]
  GKE-CA-Taiwan = local.Settings["GKE"]["Taiwan"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["Taiwan"]["Region"]
  GCPZone = local.Settings["Project"]["Taiwan"]["Zone"]
}
