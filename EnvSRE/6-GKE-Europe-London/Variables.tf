#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-EU = local.Settings["GKE"]["Europe-London"]["APIName"]
  GKE-CA-EU = local.Settings["GKE"]["Europe-London"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = "europe-west2"
  GCPZone = "europe-west2-c"
}
