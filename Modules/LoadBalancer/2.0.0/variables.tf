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
  # gameFQDNs = ["global.ponponsnake.com", "dev.ponponsnake.com", "www.ponponsnake.com"]
  gameFQDNs = formatlist("%s.%s", var.GameSubDomainNames, var.DomainName)
  # cdnFQDNs = ["cdn.ponponsnake.com", "cdn-beta.ponponsnake.com"]
  cdnFQDNs = formatlist("%s.%s", var.CDNSubDomainNames, var.DomainName)
  
  # https://stackoverflow.com/questions/59381410/how-can-i-convert-a-list-to-a-string-in-terraform

  # SubDomainsForGodaddyHelmValues = "test1\\,test2\\,test3"

  # https://developer.hashicorp.com/terraform/language/functions/join
  # join: convert an array to a string.
  # gameV1 = "test1,test2,test3"
  gameV1 = join(",", var.GameSubDomainNames)
  cdnV1 = join(",", var.CDNSubDomainNames)

  # https://developer.hashicorp.com/terraform/language/functions/replace
  # gameSubDomainsHelm = "test1\\,test2\\,test3"
  gameSubDomainsHelm = replace(local.gameV1, ",", "\\,")
  cdnSubDomainsHelm = replace(local.cdnV1, ",", "\\,")
}

variable "DomainName" {
  type = string
  #  default = "origingaia.com"
}

variable "GameSubDomainNames" {
  type        = list(string)
  #  default = ["dev", "www", "acl"]
}

variable "CDNSubDomainNames" {
  type        = list(string)
  #  default = ["dev", "www", "acl"]
}

variable "CDNUrlPathOfficial" {
  type = string
  #  default = "/official/v2.1.0"
}

variable "GodaddyAPIKey" {
  type      = string
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  sensitive = true
}
