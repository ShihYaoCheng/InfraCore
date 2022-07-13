# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.5.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = false
  DomainName         = local.DomainNameEU
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  CloudSQLProxy_Enable = false

  Prometheus_StorageClassName = "ssd-delete"
  Prometheus_StorageSize      = "100Gi"
  Prometheus_Retention        = "30d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName  = "sk-qa-eu"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-qa-info"

  ArgoCD_Enable                  = true
  ArgoCD_EnableSelfHeal          = true
  ArgoCD_EnableAllApps           = false
  ArgoCD_EnableIngress           = true
  ArgoCD_IngressUseProdCert      = true
  ArgoCD_GitLabTokenName         = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret       = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowTaipeiTime    = "* 1 * * 1-5"
  ArgoCD_AppBackstageBranchOrTag = local.AppBackstage
  ArgoCD_AppBattleBranchOrTag    = local.AppBattle
  ArgoCD_AppFileBranchOrTag      = local.AppFile
  ArgoCD_AppNFTBranchOrTag       = local.AppNFT
  ArgoCD_AppTableBranchOrTag     = local.AppTable
  ArgoCD_AppUserBranchOrTag      = local.AppUser
  ArgoCD_BackstageHelmValueFiles = local.BackstageHelmValueFiles
  ArgoCD_BattleHelmValueFiles    = local.BattleHelmValueFiles
  ArgoCD_FileHelmValueFiles      = local.FileHelmValueFiles
  ArgoCD_NFTHelmValueFiles       = local.NFTHelmValueFiles
  ArgoCD_TableHelmValueFiles     = local.TableHelmValueFiles
  ArgoCD_UserHelmValueFiles      = local.UserHelmValueFiles
}



