#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-EU = local.Settings["GKE"]["EU"]["APIName"]
  GKE-CA-EU = local.Settings["GKE"]["EU"]["CAName"]

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

  DomainName = local.Settings["Domain"]["Name"]
  SubDomainName = local.Settings["Domain"]["SubDomain"]["EU"]
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "europe-west2"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "europe-west2-a"
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

