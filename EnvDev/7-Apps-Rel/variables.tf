#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))

  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-TW-Rel = local.Settings["GKE"]["TW-Rel"]["APIName"]
  GKE-CA-TW-Rel = local.Settings["GKE"]["TW-Rel"]["CAName"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = "asia-east1"
}

#============================
# Godaddy                   #
#============================
variable "GodaddyAPIKey" {
  type      = string
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  sensitive = true
}


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
