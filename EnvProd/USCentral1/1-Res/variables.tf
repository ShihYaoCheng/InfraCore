#============================
# Project
#============================
variable "GCPProjectID" {
  type    = string
  default = "cqi-operation"
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "us-central1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "us-central1-c"
  description = "cloud provider zone."
}

