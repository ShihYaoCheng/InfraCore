#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
  default = "cqi-sk-sre"
}

variable "GCPProjectID" {
  type    = string
  default = "stellar-38931"
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "us-central1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "us-central1-a"
  description = "cloud provider zone."
}
