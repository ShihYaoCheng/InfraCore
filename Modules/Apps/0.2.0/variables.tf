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

variable "GCPZone" {
  type        = string
  #  default     = "asia-east1-b"
  description = "cloud provider zone."
}

#============================
# External-DNS              #
#============================
variable "ExternalDNS_Enable" {
  type        = bool
  default     = false
  description = "Only used for SRE environment.(It create/destroy kubernetes everyday) The Godaddy will overwrite A Record added by other Kubernetes."
}

variable "DomainName" {
  type = string
  #  default = "sre.origingaia.com"
}

variable "GodaddyAPIKey" {
  type      = string
  default   = "godaddy-api-key"
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  default   = "godaddy-api-secret"
  sensitive = true
}




#============================
# Prometheus                #
#============================
variable "Prometheus_Enable" {
  type = bool
  default = true
}

variable "AlertSlackChannel" {
  type = string
}

variable "PrometheusStorageClassName" {
  type = string
  #  default = "ssd-retain"
}

variable "PrometheusStorageSize" {
  type = string
  #  default = "100Gi"
}

variable "PrometheusRetention" {
  type = string
  default = "90d"
}

variable "GrafanaAdminPassword" {
  type = string
}

variable "CreateProductionCertificate" {
  type    = bool
  default = false
}

#============================
# Loki                      #
#============================
variable "Loki_Enable" {
  type = bool
  default = true
}

#============================
# Tempo                     #
#============================
variable "Tempo_Enable" {
  type = bool
  default = true
}

#============================
# Velero                    #
#============================
variable "Velero_Enable" {
  type = bool
  default = false
}

#============================
# Cert-Manager              #
#============================
variable "CertManager_Enable" {
  type = bool
  default = true
}

#============================
# CloudSQL Proxy            #
#============================
variable "CloudSQLProxy_Enable" {
  type = bool
  default = true
}


#============================
# ArgoCD                    #
#============================
# helm upgrade --install token ./charts/tokenserver -f ./charts/values-sre.yaml -n token --create-namespace
# helm uninstall token -n token
# helm upgrade --install user ./charts/userserver -f ./charts/values-sre.yaml -n user --create-namespace
# helm uninstall user -n user
variable "ArgoCD_Enable" {
  type    = bool
  default = true
}

variable "ArgoCD_EnableSelfHeal" {
  type    = bool
  default = true
}

variable "ArgoCD_EnableAllApps" {
  type    = bool
  default = true
}

variable "ArgoCD_GitLabTokenName" {
  type        = string
  sensitive   = true
  description = "Deploy token"
}

variable "ArgoCD_GitLabTokenSecret" {
  type        = string
  sensitive   = true
  description = "Deploy token"
}

# https://stackoverflow.com/questions/53846273/helm-passing-array-values-through-set
# https://helm.sh/docs/intro/using_helm/#the-format-and-limitations-of---set
variable "ArgoCD_RepositoryHelmPathValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_AppFileBranchOrTag" {
  type = string
}

variable "ArgoCD_AppTableBranchOrTag" {
  type = string
}

variable "ArgoCD_AppUserBranchOrTag" {
  type = string
}

variable "ArgoCD_AppBackstageBranchOrTag" {
  type = string
}

variable "ArgoCD_AppBattleBranchOrTag" {
  type = string
}

variable "ArgoCD_AppNFTBranchOrTag" {
  type = string
}

