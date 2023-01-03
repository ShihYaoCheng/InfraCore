#============================
# Project                   #
#============================
locals {
  Settings    = jsondecode(file("../Settings.json"))
  ProjectID   = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-TaiwanDev = local.Settings["GKE"]["Singapore"]["APIName"]
  GKE-CA-TaiwanDev = local.Settings["GKE"]["Singapore"]["CAName"]

  DomainName = local.Settings["Domain"]["Name"]
  SubDomainNames = local.Settings["Domain"]["SubDomain"]["Singapore"]

  CDNEnabled = local.Settings["CDN"]["Enabled"]
  CDNUrlPathOfficial = local.Settings["CDN"]["UrlPathOfficial"]
  CDNSubDomainName = local.Settings["Domain"]["SubDomain"]["LB-CDN"]
  CDNUrlOfficial = "https://${local.CDNSubDomainName}.${local.DomainName}${local.CDNUrlPathOfficial}"

  # https://cloud.google.com/compute/docs/regions-zones
  GCPRegion = local.Settings["Project"]["Singapore"]["Region"]
  GCPZone = local.Settings["Project"]["Singapore"]["Zone"]
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

