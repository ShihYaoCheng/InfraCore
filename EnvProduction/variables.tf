//============================== Project ==============================
variable "GCPProjectID" {
  default = "stellar-38931"
  type    = string
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  default     = "asia-east1"
  description = "cloud provider region."
}

variable "GCPZone" {
  default     = "asia-east1-b"
  description = "cloud provider zone."
}

//============================== Sealed-Secret ==============================
variable "SealedSecretPublicKey" {
  type = string
}

variable "SealedSecretPrivateKey" {
  type = string
}

//============================== External-DNS ==============================
variable "GodaddyAPIKey" {
  type = string
}

variable "GodaddyAPISecret" {
  type = string
}

//============================== ZeroSSL certificate ==============================
#variable "CertificatePublicKey" {
#  type = string
#  description = "SealedSecret format."
#}
#
#variable "CertificatePrivateKey" {
#  type = string
#  description = "SealedSecret format."
#}

//============================== ArgoCD ==============================
variable "ArgoCD_GitLabTokenName" {
  type = string
  sensitive = true
}

variable "ArgoCD_GitLabTokenSecret" {
  type = string
  sensitive = true
}

variable "ArgoCD_ApplicationPublicKey" {
  type = string
}

variable "ArgoCD_ApplicationPrivateKey" {
  type = string
}

# ============================== Prometheus ==============================
variable "GrafanaAdminPassword" {
  type = string
}
