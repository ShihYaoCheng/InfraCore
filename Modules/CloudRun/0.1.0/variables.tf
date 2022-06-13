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

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  #  default     = "asia-east1"
  description = "cloud provider region."
}

#============================
# Cloud Run                 #
#============================
variable "CloudRunName" {
  type = string
}

variable "CloudRunImage" {
  type = string
#  default = "gcr.io/stellar-38931/sk-battle:sre-5878b06e"
}

variable "CloudRunMinScale" {
  type = number
  default = 1
}

variable "CloudRunMaxScale" {
  type = number
  default = 1
}

#============================
# Connector                 #
#============================
variable "ConnectorSubnetName" {
  type = string
}

variable "ConnectorMachineType" {
  type = string
  default = "f1-micro"
  description = "Possible values are: [f1-micro, e2-micro, e2-standard-4]"
}
