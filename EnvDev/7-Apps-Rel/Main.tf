﻿# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps-Rel" {
  source = "../../Modules/Apps/7.0.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = "asia-east1-b"

  GodaddyDomainName        = "origingaia.com"
  EnableGodaddyPlainDomain = false
  GodaddySubDomainNames    = ["rel"]
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

  Robusta_ClusterName           = "sk-rel"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-rel-info"
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

  ArgoCD_BackstageHelmValueFiles   = "{values-beta.yaml\\, CloudSQL-Rel.yaml}"
  ArgoCD_BattleHelmValueFiles      = "{values-v3.2.0.yaml\\, EnableIngress.yaml}"
  ArgoCD_FileHelmValueFiles        = "{values-v3.2.0.yaml\\, EnableIngress.yaml}"
  ArgoCD_NFTHelmValueFiles         = "{values-beta.yaml}"
  ArgoCD_TableHelmValueFiles       = "{values-v3.2.0.yaml\\, EnableIngressReliability.yaml}"
  ArgoCD_UserHelmValueFiles        = "{values-v3.2.0.yaml\\, SetReleaseConfig.yaml\\, EnableIngressReliability.yaml\\, ConnectRelDB.yaml}"
  ArgoCD_OfficialWebHelmValueFiles = "{values-beta.yaml}"

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"
  ArgoCD_CqiPassword_Bcrypt = "$2a$10$vSB.qa1a05DVChv1XKLPxe2C/Om6xW1zFdWkFs9yOMVOOa2.hSX.i"

  providers = {
    helm       = helm.rel
    kubernetes = kubernetes.rel
  }
}
