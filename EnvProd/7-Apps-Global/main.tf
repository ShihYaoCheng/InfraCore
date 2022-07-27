# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsEU" {
  source = "../../Modules/Apps/0.6.0"

  ProjectName  = local.ProjectName
  UniqueName   = "eu"
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = false
  DomainName         = local.DomainNameEU
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = false
  CertManager_CreateProdCert = false

  CloudSQLProxy_Enable = false

  Robusta_ClusterName  = "sk-prod-eu"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-prod-info"

  Prometheus_Enable           = true
  Prometheus_StorageClassName = "ssd-retain"
  Prometheus_StorageSize      = "500Gi"
  Prometheus_Retention        = "90d"
  Grafana_AdminPassword       = var.GrafanaAdminPassword

  ArgoCD_Enable                  = true
  ArgoCD_EnableSelfHeal          = true
  ArgoCD_EnableIngress           = true
  ArgoCD_IngressUseProdCert      = true
  ArgoCD_GitLabTokenName         = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret       = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowTaipeiTime    = "* * * * *"
  ArgoCD_EnableAppBackstage      = false
  ArgoCD_EnableAppBattle         = true
  ArgoCD_EnableAppFile           = true
  ArgoCD_EnableAppNFT            = false
  ArgoCD_EnableAppTable          = false
  ArgoCD_EnableAppUser           = false
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



