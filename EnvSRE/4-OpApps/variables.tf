locals {
  GCSBucketName = "cqi-sk-sre"
}

//============================== External-DNS ==============================
variable "GodaddyAPIKey" {
  type      = string
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  sensitive = true
}