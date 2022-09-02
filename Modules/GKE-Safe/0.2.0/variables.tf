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
variable "GKE-ControlPlaneCIDR" {
  type = string
#  default = "10.0.0.0/28"
}

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

variable "GKE-CheapNodePool-2C8G" {
  type = bool
}

variable "GKE-NodePoolScale-2C8G" {
  type = bool
}

variable "GKE-MaxNum-2C8G" {
  type = number
}

variable "GKE-NodeNum-2C8G" {
  type = number
  description = "USD 56.64"
}

variable "GKE-CheapNodePool-4C16G" {
  type = bool
}

variable "GKE-NodePoolScale-4C16G" {
  type = bool
}

variable "GKE-MaxNum-4C16G" {
  type = number
}

variable "GKE-NodeNum-4C16G" {
  type = number
  description = "USD 113.28"
}
