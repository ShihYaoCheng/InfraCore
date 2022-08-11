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
  default     = "europe-west2"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "europe-west2-a"
  description = "cloud provider zone."
}
