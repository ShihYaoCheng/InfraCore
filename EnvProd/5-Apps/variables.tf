#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]
  
  AppBackstage = local.Settings["AppsVersion"]["Backstage"]
  AppBattle = local.Settings["AppsVersion"]["Battle"]
  AppFile = local.Settings["AppsVersion"]["File"]
  AppNFT = local.Settings["AppsVersion"]["NFT"]
  AppTable = local.Settings["AppsVersion"]["Table"]
  AppUser = local.Settings["AppsVersion"]["User"]

  BackstageHelmValueFiles = local.Settings["HelmPathValueFiles"]["Backstage"]
  BattleHelmValueFiles = local.Settings["HelmPathValueFiles"]["Battle"]
  FileHelmValueFiles = local.Settings["HelmPathValueFiles"]["File"]
  NFTHelmValueFiles = local.Settings["HelmPathValueFiles"]["NFT"]
  TableHelmValueFiles = local.Settings["HelmPathValueFiles"]["Table"]
  UserHelmValueFiles = local.Settings["HelmPathValueFiles"]["User"]

  DomainNameTW = local.Settings["DomainNames"]["TW"]
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "asia-east1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "asia-east1-a"
  description = "cloud provider zone."
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
# Robusta                   #
#============================
variable "Robusta_SlackAPIKey" {
  type      = string
  sensitive = true
}
