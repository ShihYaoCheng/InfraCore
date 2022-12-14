#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-London = local.Settings["GKE"]["London"]["APIName"]
  GKE-CA-London = local.Settings["GKE"]["London"]["CAName"]

  AppBattle = local.Settings["AppsVersion"]["Battle"]
  AppFile = local.Settings["AppsVersion"]["File"]

  BattleHelmValueFiles = local.Settings["HelmPathValueFiles"]["Battle"]
  FileHelmValueFiles = local.Settings["HelmPathValueFiles"]["File"]

  DomainName = local.Settings["Domain"]["Name"]
  SubDomainNames = local.Settings["Domain"]["SubDomain"]["London"]

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["London"]["Region"]
  GCPZone = local.Settings["Project"]["London"]["Zone"]
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

variable "GrafanaAdminPassword" {
  type        = string
  sensitive   = true
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
# Robusta                   #
#============================
variable "Robusta_SlackAPIKey" {
  type      = string
  sensitive = true
}

