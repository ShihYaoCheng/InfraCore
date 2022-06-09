#============================
# Project                   #
#============================
variable "GCPProjectID" {
  type    = string
  #  default = "stellar-38931"
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  #  default     = "asia-east1"
  description = "cloud provider region."
}

#============================
# Cloud Run                 #
#============================
variable "Name" {
  type = string
}

variable "Image" {
  type = string
#  default = "gcr.io/stellar-38931/sk-battle:sre-5878b06e"
}

variable "MinScale" {
  type = number
  default = 1
}

variable "MaxScale" {
  type = number
  default = 1
}
