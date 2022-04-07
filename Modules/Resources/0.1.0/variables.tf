#============================
# Project
#============================
variable "GCPProjectID" {
  type    = string
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  description = "cloud provider region."
}

variable "GCSBucketName" {
  type = string
}