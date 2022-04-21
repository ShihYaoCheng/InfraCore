#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
}

variable "GCPProjectID" {
  type = string
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  #  default     = "asia-east1-b"
  description = "cloud provider zone."
}

#============================
# CloudSQL                  #
#============================
variable "CloudSQLRootPassword" {
  type = string
  sensitive = true
}
