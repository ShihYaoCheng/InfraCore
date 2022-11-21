# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsTw" {
  source = "../../Modules/Apps/4.1.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = local.GCPZone

  GodaddyDomainName                  = local.DomainName
  EnableGodaddyPlainDomain           = true
  GodaddySubDomainNames              = [local.SubDomainName, "www", "v2.10.1", "v2.10.0", "v2.9.0", "acl"]
  GodaddyAPIKey                      = var.GodaddyAPIKey
  GodaddyAPISecret                   = var.GodaddyAPISecret
  ArgoCD_OfficialWebRedirectEnabled  = true
  ArgoCD_OfficialWebRedirectDestFQDN = "${local.SubDomainName}.${local.DomainName}"

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Robusta_ClusterName           = "sk-prod-tw"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-prod-info"
  Robusta_NotifyDeploymentEvent = true

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "300Gi"
  Prometheus_Retention        = "90d"
  Grafana_AdminPassword       = var.GrafanaAdminPassword

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = true
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = true
  ArgoCD_GitLabTokenName      = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret    = var.ArgoCD_GitLabTokenSecret
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

  ArgoCD_BackstageSqlPassword = var.BackstageSqlPassword
  ArgoCD_UserSqlPassword      = var.UserSqlPassword
}

output "Settings" {
  value = local.Settings
}

