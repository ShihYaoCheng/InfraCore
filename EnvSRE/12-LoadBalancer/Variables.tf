#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  ZoneTaiwan = local.Settings["Project"]["Taiwan"]["Zone"]
  ZoneLondon = local.Settings["Project"]["London"]["Zone"]
  ZoneSingapore = local.Settings["Project"]["Singapore"]["Zone"]
  ZoneLosAngeles = local.Settings["Project"]["LosAngeles"]["Zone"]

  GKE-API-Taiwan = local.Settings["GKE"]["TaiwanDev"]["APIName"]
  GKE-CA-Taiwan = local.Settings["GKE"]["TaiwanDev"]["CAName"]
  GKE-API-London = local.Settings["GKE"]["London"]["APIName"]
  GKE-CA-London = local.Settings["GKE"]["London"]["CAName"]
  GKE-API-Singapore = local.Settings["GKE"]["Singapore"]["APIName"]
  GKE-CA-Singapore = local.Settings["GKE"]["Singapore"]["CAName"]
  GKE-API-LosAngeles = local.Settings["GKE"]["LosAngeles"]["APIName"]
  GKE-CA-LosAngeles = local.Settings["GKE"]["LosAngeles"]["CAName"]

  DomainName = local.Settings["Domain"]["Name"]
  GameSubDomainName = local.Settings["Domain"]["SubDomain"]["LB-Game"]
  
  CDNSubDomainName = local.Settings["Domain"]["SubDomain"]["LB-CDN"]
  CDNEnabled = local.Settings["CDN"]["Enabled"]
  CDNUrlPathOfficial = local.Settings["CDN"]["UrlPathOfficial"]
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "asia-east1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "asia-east1"
  description = "cloud provider zone."
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