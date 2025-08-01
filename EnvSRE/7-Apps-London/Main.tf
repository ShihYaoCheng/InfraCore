﻿# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsLondon" {
  source = "../../Modules/Apps/7.0.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = local.GCPZone

  GodaddyDomainName                  = local.DomainName
  GodaddySubDomainNames              = local.SubDomainNames
  GodaddyAPIKey                      = var.GodaddyAPIKey
  GodaddyAPISecret                   = var.GodaddyAPISecret
  EnableGodaddyPlainDomain           = false
  
  ArgoCD_OfficialWebRedirectEnabled  = false
  ArgoCD_OfficialWebRedirectDestFQDN = ""
  ArgoCD_OfficialWebCDNEnabled       = false
  ArgoCD_OfficialWebCDNUrl           = ""
  ArgoCD_OfficialKey                 = ""
  ArgoCD_BackstageKey                = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = false

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "20Gi"
  Prometheus_Retention        = "1d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName           = "sre-london"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-sre-info"
  Robusta_NotifyDeploymentEvent = false

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = false
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = false
  ArgoCD_GitLabTokenName      = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret    = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowTaipeiTime = "* * * * *"
  ArgoCD_EnableAppBackstage   = false
  ArgoCD_EnableAppBattle      = true
  ArgoCD_EnableAppFile        = true
  ArgoCD_EnableAppNFT         = false
  ArgoCD_EnableAppTable       = false
  ArgoCD_EnableAppUser        = false
  ArgoCD_EnableAppOfficialWeb = false

  ArgoCD_AppFileBranchOrTag        = "main"
  ArgoCD_AppTableBranchOrTag       = "main"
  ArgoCD_AppUserBranchOrTag        = "main"
  ArgoCD_AppBackstageBranchOrTag   = "main"
  ArgoCD_AppBattleBranchOrTag      = "main"
  ArgoCD_AppNFTBranchOrTag         = "main"
  ArgoCD_AppOfficialWebBranchOrTag = "main"

  ArgoCD_BackstageHelmValueFiles   = "{}"
  ArgoCD_BattleHelmValueFiles      = "{values-sre.yaml\\, EnableNEG.yaml}"
  ArgoCD_FileHelmValueFiles        = "{values-sre.yaml\\, EnableNEG.yaml}"
  ArgoCD_NFTHelmValueFiles         = "{}"
  ArgoCD_TableHelmValueFiles       = "{}"
  ArgoCD_UserHelmValueFiles        = "{}"
  ArgoCD_OfficialWebHelmValueFiles = "{}"

  ArgoCD_BackstageSqlPassword = ""
  ArgoCD_UserSqlPassword      = ""
  ArgoCD_CqiPassword_Bcrypt = "$2a$10$vSB.qa1a05DVChv1XKLPxe2C/Om6xW1zFdWkFs9yOMVOOa2.hSX.i"
}



