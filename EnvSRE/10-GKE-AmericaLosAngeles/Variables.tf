#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-Singapore = local.Settings["GKE"]["Singapore"]["APIName"]
  GKE-CA-Singapore = local.Settings["GKE"]["Singapore"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = "asia-southeast1"
  GCPZone = "asia-southeast1-b"
}
