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

variable "GKE-NodeCount-e2-standard-2" {
  type = number
  default = 2
}

variable "GKE-NodeCount-e2-medium" {
  type = number
  default = 1
}

variable "GKE-AutoScaling-MinCPU" {
  type = number
  default = 1
}

variable "GKE-AutoScaling-MaxCPU" {
  type = number
  default = 5
}

variable "GKE-AutoScaling-MinMemoryGB" {
  type = number
  default = 5
}

variable "GKE-AutoScaling-MaxMemoryGB" {
  type = number
  default = 13
}
