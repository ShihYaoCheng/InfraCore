#============================
# Project                   #
#============================
locals {
  Settings    = jsondecode(file("../Settings.json"))
  ProjectID   = local.Settings["Project"]["ID"]
  ProjectName = local.Settings["Project"]["Name"]
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
# External-DNS              #
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
# ArgoCD                    #
#============================
variable "Robusta_SlackAPIKey" {
  type      = string
  sensitive = true
}

