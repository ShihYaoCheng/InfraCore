#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]

  GKE-API-Singapore = local.Settings["GKE"]["Singapore"]["APIName"]
  GKE-CA-Singapore = local.Settings["GKE"]["Singapore"]["CAName"]

  DomainName = local.Settings["Domain"]["Name"]
  SubDomainNames = local.Settings["Domain"]["SubDomain"]["Singapore"]

  GCPRegion = local.Settings["Project"]["Singapore"]["Region"]
  GCPZone = local.Settings["Project"]["Singapore"]["Zone"]
}

# https://cloud.google.com/compute/docs/regions-zones
#variable "GCPRegion" {
#  type        = string
#  default     = "asia-southeast1"
#  description = "cloud provider region."
#}
#
#variable "GCPZone" {
#  type        = string
#  default     = "asia-southeast1-b"
#  description = "cloud provider zone."
#}

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
