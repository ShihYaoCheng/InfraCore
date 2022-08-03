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

variable "GCPZone" {
  type        = string
#  default     = "asia-east1-b"
  description = "cloud provider zone."
}

#============================
# GKE                       #
#============================
variable "GKE-Zones" {
  type = list(string)
#  default = ["asia-east1-a"]
}

variable "GKE-APIName" {
  type = string
}

variable "GKE-CAName" {
  type = string
}

variable "GKE-Labels" {
  type = map(string)
  default = {}
#  default = {"name"="sre"}
}

#variable "GKE-NodeCount-e2-high-cpu-2" {
#  type = number
##  default = 0
#  description = "USD 41.82"
#}
#
#variable "GKE-NodeCount-e2-high-cpu-4" {
#  type = number
##  default = 0
#  description = "USD 83.63"
#}

variable "GKE-EnableScale-e2-standard-2" {
  type = bool
}

variable "GKE-MaxCount-e2-standard-2" {
  type = number
}

variable "GKE-NodeCount-e2-standard-2" {
  type = number
  description = "USD 56.64"
}

variable "GKE-EnableScale-e2-standard-4" {
  type = bool
}

variable "GKE-MaxCount-e2-standard-4" {
  type = number
}

variable "GKE-NodeCount-e2-standard-4" {
  type = number
  description = "USD 113.28"
}

#variable "GKE-NodeCount-e2-medium" {
#  type = number
##  default = 0
#  description = "USD 28.32"
#}

#variable "GKE-AutoScaling-MinCPU" {
#  type = number
#  default = 1
#}
#
#variable "GKE-AutoScaling-MaxCPU" {
#  type = number
#  default = 6
#}
#
#variable "GKE-AutoScaling-MinMemoryGB" {
#  type = number
#  default = 5
#}
#
#variable "GKE-AutoScaling-MaxMemoryGB" {
#  type = number
#  default = 20
#}
