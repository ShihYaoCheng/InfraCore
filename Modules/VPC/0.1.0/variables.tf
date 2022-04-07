#============================
# Project
#============================
variable "GCPProjectID" {
  type    = string
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
}

variable "VPCName" {
  type = string
}

variable "GCSBucketName" {
  type = string
}
