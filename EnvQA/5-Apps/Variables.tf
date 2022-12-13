#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-Taiwan = local.Settings["GKE"]["Taiwan"]["APIName"]
  GKE-CA-Taiwan = local.Settings["GKE"]["Taiwan"]["CAName"]
  
  AppBackstage = local.Settings["AppsVersion"]["Backstage"]
  AppBattle = local.Settings["AppsVersion"]["Battle"]
  AppFile = local.Settings["AppsVersion"]["File"]
  AppNFT = local.Settings["AppsVersion"]["NFT"]
  AppTable = local.Settings["AppsVersion"]["Table"]
  AppUser = local.Settings["AppsVersion"]["User"]
  AppOfficialWeb = local.Settings["AppsVersion"]["OfficialWeb"]
  
  BackstageHelmValueFiles = local.Settings["HelmPathValueFiles"]["Backstage"]
  BattleHelmValueFiles = local.Settings["HelmPathValueFiles"]["Battle"]
  FileHelmValueFiles = local.Settings["HelmPathValueFiles"]["File"]
  NFTHelmValueFiles = local.Settings["HelmPathValueFiles"]["NFT"]
  TableHelmValueFiles = local.Settings["HelmPathValueFiles"]["Table"]
  UserHelmValueFiles = local.Settings["HelmPathValueFiles"]["User"]
  OfficialWebHelmValueFiles = local.Settings["HelmPathValueFiles"]["OfficialWeb"]

  DomainName = local.Settings["Domain"]["Name"]
  SubDomainNames = local.Settings["Domain"]["SubDomain"]["Taiwan"]

  CDNEnabled = local.Settings["CDN"]["Enabled"]
  CDNUrlPathOfficial = local.Settings["CDN"]["UrlPathOfficial"]
  CDNSubDomainName = local.Settings["Domain"]["SubDomain"]["LB-CDN"]
  CDNUrlOfficial = "https://${local.CDNSubDomainName}.${local.DomainName}${local.CDNUrlPathOfficial}"

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["Taiwan"]["Region"]
  GCPZone = local.Settings["Project"]["Taiwan"]["Zone"]
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

