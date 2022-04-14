#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
}

variable "GCPProjectID" {
  type    = string
#  default = "stellar-38931"
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
#  default     = "asia-east1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
#  default     = "asia-east1-b"
  description = "cloud provider zone."
}

#============================
# GKE                       #
#============================
variable "GKE-VPCName" {
  type = string
  default = ""
}

variable "GKE-Zones" {
  type = list(string)
#  default = ["asia-east1-a"]
}
