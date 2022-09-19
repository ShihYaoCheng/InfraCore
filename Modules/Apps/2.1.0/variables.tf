#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
}

variable "UniqueName" {
  type        = string
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
# Godaddy                   #
#============================
locals {
  GodaddyFQDN1 = var.GodaddySubDomainName1 != "@" ? "${var.GodaddySubDomainName1}.${var.GodaddyDomainName}" : var.GodaddyDomainName
  GodaddyFQDN2 = var.GodaddySubDomainName2 != "@" ? "${var.GodaddySubDomainName2}.${var.GodaddyDomainName}" : var.GodaddyDomainName
  GodaddyFQDNs = var.GodaddySubDomainName2 != "" ? "{${local.GodaddyFQDN1}\\, ${local.GodaddyFQDN2}}" : "{${local.GodaddyFQDN1}}"
}

variable "GodaddyDomainName" {
  type = string
  #  default = "origingaia.com"
}

variable "GodaddySubDomainName1" {
  type = string
  #  default = "dev"
  description = "@ = empty"
}

variable "GodaddySubDomainName2" {
  type = string
  #  default = "@"
  description = "@ = empty"
}

variable "GodaddyAPIKey" {
  type      = string
  sensitive = true
}

variable "GodaddyAPISecret" {
  type      = string
  sensitive = true
}


#============================
# Prometheus                #
#============================
variable "Prometheus_StorageClassName" {
  type = string
  #  default = "ssd-retain"
}

variable "Prometheus_StorageSize" {
  type = string
  #  default = "100Gi"
}

variable "Prometheus_Retention" {
  type = string
#  default = "90d"
}

variable "Grafana_AdminPassword" {
  type = string
}

#============================
# Robusta                   #
#============================
variable "Robusta_SlackChannel" {
  type = string
}

variable "Robusta_SlackAPIKey" {
  type      = string
  sensitive = true
}

variable "Robusta_ClusterName" {
  type = string
}

variable "Robusta_NotifyDeploymentEvent" {
  type = bool
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
  default = false
}

#============================
# Velero                    #
#============================
variable "Velero_Enable" {
  type = bool
  default = false
}

variable "Velero_BackupSchedule" {
  type = string
  default = "0 1 * * *"
}

variable "Velero_BackupScheduleTTL" {
  type = string
  default = "720h" 
  description = "How long the backup file will be deleted. 720h = 30d"
}

#============================
# Cert-Manager              #
#============================
variable "CertManager_Enable" {
  type = bool
#  default = true
}

variable "CertManager_CreateProdCert" {
  type    = bool
  #  default = false
}


#============================
# CloudSQL Proxy            #
#============================
variable "CloudSQLProxy_Enable" {
  type = bool
#  default = true
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
#  default = true
}

variable "ArgoCD_EnableSelfHeal" {
  type    = bool
#  default = true
}

variable "ArgoCD_EnableAppBattle" {
  type = bool
}

variable "ArgoCD_EnableAppBackstage" {
  type = bool
}

variable "ArgoCD_EnableAppOfficialWeb" {
  type = bool
}

variable "ArgoCD_EnableAppFile" {
  type = bool
}

variable "ArgoCD_EnableAppNFT" {
  type = bool
}

variable "ArgoCD_EnableAppTable" {
  type = bool
}

variable "ArgoCD_EnableAppUser" {
  type = bool
}

variable "ArgoCD_EnableIngress" {
  type    = bool
#  default = false
}

variable "ArgoCD_IngressUseProdCert" {
  type    = bool
#  default = false
}

variable "ArgoCD_SyncWindowTaipeiTime" {
  type = string
#  default = "* * * * *"
  description = "Timezone: UTC + 0. Cron format: minute(0~59), hour(0~23), day of the month(1~31), month(1~12),day of the week (0~6)(Sunday to Saturday; 7 is also Sunday on some systems)"
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
variable "ArgoCD_BackstageSqlPassword" {
  type        = string
  sensitive   = true
}

variable "ArgoCD_BackstageHelmValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_OfficialWebHelmValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_BattleHelmValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_FileHelmValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_NFTHelmValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_TableHelmValueFiles" {
  type        = string
  description = "Sample: {values-sre.yaml}"
}

variable "ArgoCD_UserSqlPassword" {
  type        = string
  sensitive   = true
}

variable "ArgoCD_UserHelmValueFiles" {
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

variable "ArgoCD_AppOfficialWebBranchOrTag" {
  type = string
}

variable "ArgoCD_AppBattleBranchOrTag" {
  type = string
}

variable "ArgoCD_AppNFTBranchOrTag" {
  type = string
}

variable "ArgoCD_OfficialWebRedirectSrcFQDN" {
  type = string
}

variable "ArgoCD_OfficialWebRedirectDestFQDN" {
  type = string
}
