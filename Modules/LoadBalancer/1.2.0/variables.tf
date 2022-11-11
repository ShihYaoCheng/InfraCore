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
  # GodaddyFQDN = "${var.GodaddySubDomainName}.${var.GodaddyDomainName}"
  GodaddyFQDNs = formatlist("%s.%s", var.GodaddySubDomainNames, var.GodaddyDomainName)
  
  # https://stackoverflow.com/questions/59381410/how-can-i-convert-a-list-to-a-string-in-terraform

  # GodaddySubDomainNames = ["test1","test2","test3"]
  # v1 = "test1,test2,test3"
  # SubDomainsForGodaddyHelmValues = "test1\\,test2\\,test3"

  # https://developer.hashicorp.com/terraform/language/functions/join
  # join: convert an array to a string.
  v1 = join(",", var.GodaddySubDomainNames)

  # https://developer.hashicorp.com/terraform/language/functions/replace
  SubDomainsForGodaddyHelmValues = replace(local.v1, ",", "\\,")
}

variable "GodaddyDomainName" {
  type = string
  #  default = "origingaia.com"
}

variable "GodaddySubDomainNames" {
  type        = list(string)
  #  default = ["dev", "www", "acl"]
}

variable "GodaddyAPIKey" {
  type      = string
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  sensitive = true
}
