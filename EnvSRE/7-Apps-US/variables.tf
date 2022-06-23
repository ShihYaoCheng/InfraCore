#============================
# Project                   #
#============================
locals {
  ProjectName = file("../ProjectName.txt")
}

variable "GCPProjectID" {
  type    = string
  default = "stellar-38931"
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "us-central1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "us-central1-a"
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
