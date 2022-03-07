//============================== GCP Project ==============================
variable "GCPProjectID" {
  type    = string
}

// https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  description = "cloud provider region."
}

variable "GCPZone" {
  description = "cloud provider zone."
}

//============================== Game Project ==============================
variable "ProjectAbbreviation" {
  default = "sk"
  type    = string
}

variable "ProjectEnvironment" {
  type    = string
}

//============================== locals ==============================
locals {
  VPCName = "${var.ProjectAbbreviation}-${var.ProjectEnvironment}"
  GKEName = "${var.ProjectAbbreviation}-${var.ProjectEnvironment}"
  ProjectName = "${var.ProjectAbbreviation}-${var.ProjectEnvironment}"

  EnvDomainName = "${var.ProjectEnvironment}.${var.GodaddyDomainName}"
}

//============================== GKE ==============================
variable "GKERegional" {
  type = bool
}

variable "GKEZones" {
  type = list(string)
}

variable "GKEMinNodeCount" {
  type = number
}

variable "GKEMaxNodeCount" {
  type = number
}


//============================== Sealed-Secret ==============================
#variable "SealedSecretPublicKey" {
#  type = string
#}
#
#variable "SealedSecretPrivateKey" {
#  type = string
#}

//============================== External-DNS ==============================
variable "GodaddyAPIKey" {
  type = string
}

variable "GodaddyAPISecret" {
  type = string
}

variable "GodaddyDomainName" {
  type = string
  default = "origingaia.com"
}

variable "AutoRegisterDomainName" {
  type = bool
  default = false
  description = "Only used for SRE environment.(It create/destroy kubernetes everyday) The Godaddy will overwrite A Record added by other Kubernetes."
}

//============================== ArgoCD ==============================
# helm upgrade --install token ./charts/tokenserver -f ./charts/values-sre.yaml -n token --create-namespace
# helm uninstall token -n token
# helm upgrade --install user ./charts/userserver -f ./charts/values-sre.yaml -n user --create-namespace
# helm uninstall user -n user
variable "ArgoCD_Enable" {
  type = bool
  default = true
}

variable "ArgoCD_GitLabTokenName" {
  type = string
  sensitive = true
  description = "Deploy token"
}

variable "ArgoCD_GitLabTokenSecret" {
  type = string
  sensitive = true
  description = "Deploy token"
}

variable "ArgoCD_AppTokenBranchOrTag" {
  type = string
  description = "branch name, for example: master, sre, production, or tag name, for example: 0.1.1, 0.2.3."
}

variable "ArgoCD_AppUserBranchOrTag" {
  type = string
  description = "branch name, for example: master, sre, production, or tag name, for example: 0.1.1, 0.2.3."
}

# https://stackoverflow.com/questions/53846273/helm-passing-array-values-through-set
# https://helm.sh/docs/intro/using_helm/#the-format-and-limitations-of---set
variable "ArgoCD_RepositoryHelmPathValueFiles" {
  type = string
  description = "Sample: {../values-sre.yaml}"
}

variable "ArgoCD_ApplicationPublicKey" {
  type = string
}

variable "ArgoCD_ApplicationPrivateKey" {
  type = string
}

//============================== Prometheus ==============================
variable "AlertSlackChannel" {
  type = string
  default = "monitoring"
}

variable "PrometheusStorageClassName" {
  type = string
  default = "ssd-retain"
}

variable "PrometheusStorageSize" {
  type = string
  default = "100Gi"
}

variable "GrafanaAdminPassword" {
  type = string
}

//============================== Cert-Manager ==============================
variable "CreateStagingCertificate" {
  type = bool
  default = true
}

variable "CreateProductionCertificate" {
  type = bool
}

#variable "UseProductionCertificate" {
#  type = bool
#  default = true
#}