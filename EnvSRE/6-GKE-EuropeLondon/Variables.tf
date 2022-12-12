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
  GCPRegion = "europe-west2"
  GCPZone = "europe-west2-c"
}
