#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-TW = local.Settings["GKE"]["TW-Dev"]["APIName"]
  GKE-CA-TW = local.Settings["GKE"]["TW-Dev"]["CAName"]
  GKE-API-EU = local.Settings["GKE"]["EU"]["APIName"]
  GKE-CA-EU = local.Settings["GKE"]["EU"]["CAName"]

  DomainName = local.Settings["Domain"]["Name"]
  GameSubDomainName = local.Settings["Domain"]["SubDomain"]["GameLoadBalancer"]
  CDNSubDomainName = local.Settings["Domain"]["SubDomain"]["CDNLoadBalancer"]
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