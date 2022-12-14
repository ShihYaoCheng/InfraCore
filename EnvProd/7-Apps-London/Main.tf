# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsLondon" {
  source = "../../Modules/Apps/5.1.1"

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

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "300Gi"
  Prometheus_Retention        = "90d"
  Grafana_AdminPassword       = var.GrafanaAdminPassword

  Robusta_ClusterName           = "sk-prod-london"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-prod-info"
  Robusta_NotifyDeploymentEvent = true

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = true
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = true
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

  ArgoCD_AppBackstageBranchOrTag   = ""
  ArgoCD_AppBattleBranchOrTag      = local.AppBattle
  ArgoCD_AppFileBranchOrTag        = local.AppFile
  ArgoCD_AppNFTBranchOrTag         = ""
  ArgoCD_AppTableBranchOrTag       = ""
  ArgoCD_AppUserBranchOrTag        = ""
  ArgoCD_AppOfficialWebBranchOrTag = ""

  ArgoCD_BackstageHelmValueFiles   = "{}"
  ArgoCD_BattleHelmValueFiles      = local.BattleHelmValueFiles
  ArgoCD_FileHelmValueFiles        = local.FileHelmValueFiles
  ArgoCD_NFTHelmValueFiles         = "{}"
  ArgoCD_TableHelmValueFiles       = "{}"
  ArgoCD_UserHelmValueFiles        = "{}"
  ArgoCD_OfficialWebHelmValueFiles = "{}"

  ArgoCD_BackstageSqlPassword = ""
  ArgoCD_UserSqlPassword      = ""
}

output "Settings" {
  value = local.Settings
}

