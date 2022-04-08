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
