#============================
# Project                   #
#============================
locals {
  ProjectID             = file("../ProjectID.txt")
  CloudSQLAdminPassword = "admin1234"
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

