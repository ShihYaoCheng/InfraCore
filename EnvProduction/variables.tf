//============================== Project ==============================
variable "GCPProjectID" {
  type    = string
  default = "cqi-operation"
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  default     = "asia-east1"
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  default     = "asia-east1-a"
  description = "cloud provider zone."
}

//============================== Sealed-Secret ==============================
#variable "SealedSecretPublicKey" {
#  type = string
#}
#
#variable "SealedSecretPrivateKey" {
#  type = string
#}

//============================== ArgoCD ==============================
variable "ArgoCD_GitLabTokenName" {
  type      = string
  sensitive = true
}

variable "ArgoCD_GitLabTokenSecret" {
  type      = string
  sensitive = true
}

# ============================== Prometheus ==============================
variable "GrafanaAdminPassword" {
  type      = string
  sensitive = true
}
