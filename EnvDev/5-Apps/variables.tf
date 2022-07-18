#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))

  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-TW = local.Settings["GKE"]["TW-Dev"]["APIName"]
  GKE-CA-TW = local.Settings["GKE"]["TW-Dev"]["CAName"]
  GKE-API-TW-Rel = local.Settings["GKE"]["TW-Rel"]["APIName"]
  GKE-CA-TW-Rel = local.Settings["GKE"]["TW-Rel"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = "asia-east1"
#  GCPZone = "asia-east1-a"
}

# https://cloud.google.com/compute/docs/regions-zones
#variable "GCPRegion" {
#  type        = string
#  default     = "asia-east1"
#  description = "cloud provider region."
#}
#
#variable "GCPZone" {
#  type        = string
#  default     = "asia-east1-b"
#  description = "cloud provider zone."
#}

#============================
# ArgoCD                    #
#============================
variable "ArgoCD_GitLabTokenName" {
  type        = string
  sensitive   = true
  description = "Deploy token"
}

variable "ArgoCD_GitLabTokenSecret" {
  type        = string
  sensitive   = true
  description = "Deploy token"
}

#============================
# Robusta                   #
#============================
variable "Robusta_SlackAPIKey" {
  type      = string
  sensitive = true
}
