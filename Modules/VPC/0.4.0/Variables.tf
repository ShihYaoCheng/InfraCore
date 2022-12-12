#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
  description = "Unique name for every resource."
}

variable "GCPProjectID" {
  type = string
  description = "Set GCP Project ID."
}

variable "GCPRegion" {
  type = string
  description = "reference: https://cloud.google.com/compute/docs/regions-zones"
}

