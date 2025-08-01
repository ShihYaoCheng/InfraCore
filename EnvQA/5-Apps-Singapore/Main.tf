﻿# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps-SG" {
  source = "../../Modules/Apps/6.0.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = local.GCPZone

  GodaddyDomainName        = local.DomainName
  EnableGodaddyPlainDomain = false
  GodaddySubDomainNames    = local.SubDomainNames
  GodaddyAPIKey            = var.GodaddyAPIKey
  GodaddyAPISecret         = var.GodaddyAPISecret

  ArgoCD_OfficialWebRedirectEnabled  = false
  ArgoCD_OfficialWebRedirectDestFQDN = ""
  ArgoCD_OfficialWebCDNEnabled       = local.CDNEnabled
  ArgoCD_OfficialWebCDNUrl           = local.CDNUrlOfficial
  ArgoCD_OfficialKey                 = "official1234"
  ArgoCD_BackstageKey                = "backstage1234"

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "60Gi"
  Prometheus_Retention        = "30d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName           = "sk-qa-sg"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-qa-info"
  Robusta_NotifyDeploymentEvent = true

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = true
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = true
  ArgoCD_GitLabTokenName      = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret    = var.ArgoCD_GitLabTokenSecret
#  ArgoCD_SyncWindowTaipeiTime = "* 2 * * 1-5"
  ArgoCD_SyncWindowTaipeiTime = "* * * * *"

  ArgoCD_EnableAppBackstage   = true
  ArgoCD_EnableAppBattle      = true
  ArgoCD_EnableAppFile        = true
  ArgoCD_EnableAppNFT         = true
  ArgoCD_EnableAppTable       = true
  ArgoCD_EnableAppUser        = true
  ArgoCD_EnableAppOfficialWeb = true

  ArgoCD_AppBackstageBranchOrTag   = local.AppBackstage
  ArgoCD_AppBattleBranchOrTag      = local.AppBattle
  ArgoCD_AppFileBranchOrTag        = local.AppFile
  ArgoCD_AppNFTBranchOrTag         = local.AppNFT
  ArgoCD_AppTableBranchOrTag       = local.AppTable
  ArgoCD_AppUserBranchOrTag        = local.AppUser
  ArgoCD_AppOfficialWebBranchOrTag = local.AppOfficialWeb

  ArgoCD_BackstageHelmValueFiles   = local.BackstageHelmValueFiles
  ArgoCD_BattleHelmValueFiles      = local.BattleHelmValueFiles
  ArgoCD_FileHelmValueFiles        = local.FileHelmValueFiles
  ArgoCD_NFTHelmValueFiles         = local.NFTHelmValueFiles
  ArgoCD_TableHelmValueFiles       = local.TableHelmValueFiles
  ArgoCD_UserHelmValueFiles        = local.UserHelmValueFiles
  ArgoCD_OfficialWebHelmValueFiles = local.OfficialWebHelmValueFiles

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"
}

output "Settings" {
  value = local.Settings
}

