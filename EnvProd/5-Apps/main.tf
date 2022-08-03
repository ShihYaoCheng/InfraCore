# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsTw" {
  source = "../../Modules/Apps/1.1.0"

  ProjectName  = local.ProjectName
  UniqueName   = "tw"
  GCPProjectID = local.ProjectID
  GCPZone      = local.GCPZone

  ExternalDNS_Enable = false
  DomainName         = local.DomainNameTW
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Robusta_ClusterName  = "sk-prod-tw"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-prod-info"

  Prometheus_StorageClassName = "ssd-retain"
  Prometheus_StorageSize      = "800Gi"
  Prometheus_Retention        = "90d"
  Grafana_AdminPassword       = var.GrafanaAdminPassword

  CloudSQLProxy_Enable = true

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



