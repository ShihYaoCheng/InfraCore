#============================== External-DNS ==============================
variable "GodaddyAPIKey" {
  type    = string
  default = "godaddy-api-key"
  sensitive = true
}

variable "GodaddyAPISecret" {
  type    = string
  default = "godaddy-api-secret"
  sensitive = true
}

variable "GodaddyDomainName" {
  type    = string
  default = "origingaia.com"
}

variable "AutoRegisterDomainName" {
  type        = bool
  default     = false
  description = "Only used for SRE environment.(It create/destroy kubernetes everyday) The Godaddy will overwrite A Record added by other Kubernetes."
}