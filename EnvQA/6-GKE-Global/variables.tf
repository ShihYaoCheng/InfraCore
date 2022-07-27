#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-EU = local.Settings["GKE"]["EU"]["APIName"]
  GKE-CA-EU = local.Settings["GKE"]["EU"]["CAName"]

  GCPRegion = "europe-west2"
  GCPZone = "europe-west2-a"
}

# https://cloud.google.com/compute/docs/regions-zones
#variable "GCPRegion" {
#  type        = string
#  default     = "europe-west2"
#  description = "cloud provider region."
#}
#
#variable "GCPZone" {
#  type        = string
#  default     = "europe-west2-a"
#  description = "cloud provider zone."
#}
