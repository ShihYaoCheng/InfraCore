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
  default     = "asia-east1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "asia-east1-b"
  description = "cloud provider zone."
}


