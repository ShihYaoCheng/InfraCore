#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
  default = "cqi-sk-qa"
}

variable "GCPProjectID" {
  type    = string
  default = "cqi-operation"
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
# Grafana                   #
#============================
variable "GrafanaAdminPassword" {
  type      = string
  sensitive = true
}
