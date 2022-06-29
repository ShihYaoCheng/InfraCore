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
  default     = "europe-west2"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "europe-west2-b"
  description = "cloud provider zone."
}

