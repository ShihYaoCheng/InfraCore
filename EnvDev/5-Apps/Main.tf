﻿# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/7.0.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = "asia-east1-a"

  GodaddyDomainName        = "origingaia.com"
  EnableGodaddyPlainDomain = false
  GodaddySubDomainNames    = ["dev"]
  GodaddyAPIKey            = var.GodaddyAPIKey
  GodaddyAPISecret         = var.GodaddyAPISecret

  ArgoCD_OfficialWebRedirectEnabled  = false
  ArgoCD_OfficialWebRedirectDestFQDN = ""
  ArgoCD_OfficialWebCDNEnabled       = false
  ArgoCD_OfficialWebCDNUrl           = ""
  ArgoCD_OfficialKey                 = "official1234"
  ArgoCD_BackstageKey                = "backstage1234"

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "60Gi"
  Prometheus_Retention        = "60d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName           = "sk-dev"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-dev-info"
  Robusta_NotifyDeploymentEvent = false

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = true
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = true
  ArgoCD_SyncWindowTaipeiTime = "* * * * *"
  ArgoCD_GitLabTokenName      = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret    = var.ArgoCD_GitLabTokenSecret

  ArgoCD_EnableAppBackstage   = true
  ArgoCD_EnableAppBattle      = true
  ArgoCD_EnableAppFile        = true
  ArgoCD_EnableAppNFT         = true
  ArgoCD_EnableAppTable       = true
  ArgoCD_EnableAppUser        = true
  ArgoCD_EnableAppOfficialWeb = true

  ArgoCD_AppBackstageBranchOrTag   = "main"
  ArgoCD_AppBattleBranchOrTag      = "main"
  ArgoCD_AppFileBranchOrTag        = "main"
  ArgoCD_AppNFTBranchOrTag         = "main"
  ArgoCD_AppTableBranchOrTag       = "main"
  ArgoCD_AppUserBranchOrTag        = "main"
  ArgoCD_AppOfficialWebBranchOrTag = "main"

  ArgoCD_BackstageHelmValueFiles   = "{values-main.yaml}"
  ArgoCD_BattleHelmValueFiles      = "{values-main.yaml}"
  ArgoCD_FileHelmValueFiles        = "{values-main.yaml}"
  ArgoCD_NFTHelmValueFiles         = "{values-main.yaml}"
  ArgoCD_TableHelmValueFiles       = "{values-main.yaml}"
  ArgoCD_UserHelmValueFiles        = "{values-main.yaml}"
  ArgoCD_OfficialWebHelmValueFiles = "{values-main.yaml}"

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"
  ArgoCD_CqiPassword_Bcrypt = "$2a$10$vSB.qa1a05DVChv1XKLPxe2C/Om6xW1zFdWkFs9yOMVOOa2.hSX.i"

  providers = {
    helm       = helm.dev
    kubernetes = kubernetes.dev
  }
}
