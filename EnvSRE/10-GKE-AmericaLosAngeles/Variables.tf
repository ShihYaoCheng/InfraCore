#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-LosAngeles = local.Settings["GKE"]["LosAngeles"]["APIName"]
  GKE-CA-LosAngeles = local.Settings["GKE"]["LosAngeles"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["LosAngeles"]["Region"]
  GCPZone = local.Settings["Project"]["LosAngeles"]["Zone"]
}
