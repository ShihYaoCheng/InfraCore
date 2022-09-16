#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
#  default = "cqi-sk-test"
}

variable "ZoneTW" {
  type = string
}

variable "ZoneEU" {
  type = string
}

#============================
# Godaddy                   #
#============================
locals {
  GodaddyFQDN = "${var.GodaddySubDomainName}.${var.GodaddyDomainName}"
}

variable "GodaddyDomainName" {
  type = string
  #  default = "origingaia.com"
}

variable "GodaddySubDomainName" {
  type = string
  #  default = "dev"
}

variable "GodaddyAPIKey" {
  type      = string
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  sensitive = true
}
