//============================== Project ==============================
variable "project-id" {
  default = "stellar-38931"
  type    = string
}

// https://cloud.google.com/compute/docs/regions-zones
variable "region" {
  default     = "asia-east1"
  description = "cloud provider region."
}

variable "zone" {
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