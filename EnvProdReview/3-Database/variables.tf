#============================
# Project                   #
#============================
locals {
  ProjectID = file("../ProjectID.txt")
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
# CloudSQL                  #
#============================
variable "CloudSQLAdminPassword" {
  type = string
  sensitive = true
}


