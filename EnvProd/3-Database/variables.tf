#============================
# Project                   #
#============================
locals {
  Settings = jsondecode(file("../Settings.json"))
  ProjectID = local.Settings["Project"]["ID"]
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

variable "CloudSQLAdminPassword" {
  type = string
  sensitive = true
}

variable "CloudSQLBackstagePassword" {
  type = string
  sensitive = true
}

variable "CloudSQLUserPassword" {
  type = string
  sensitive = true
}
