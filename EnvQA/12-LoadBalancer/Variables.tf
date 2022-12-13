#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-TW = local.Settings["GKE"]["TW"]["APIName"]
  GKE-CA-TW = local.Settings["GKE"]["TW"]["CAName"]
  GKE-API-EU = local.Settings["GKE"]["EU"]["APIName"]
  GKE-CA-EU = local.Settings["GKE"]["EU"]["CAName"]
  
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

