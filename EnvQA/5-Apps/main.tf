# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.4.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = false
  DomainName         = "v2.6.0.ponponsnake.com"
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Prometheus_Enable            = true
  Prometheus_AlertSlackChannel = "alert-sk-prod-qa"
  Prometheus_StorageClassName  = "ssd-delete"
  Prometheus_StorageSize       = "100Gi"
  Prometheus_Retention         = "30d"
  Grafana_AdminPassword        = "gra4422"

  Robusta_ClusterName  = "sk-qa"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-qa-info"

  CloudSQLProxy_Enable = true

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = true
  ArgoCD_EnableAllApps                = true
  ArgoCD_EnableIngress                = true
  ArgoCD_IngressUseProdCert           = true
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowCronTime           = "* * * * *"
  ArgoCD_RepositoryHelmPathValueFiles = local.HelmPathValueFiles
  ArgoCD_AppBackstageBranchOrTag      = local.AppBackstage
  ArgoCD_AppBattleBranchOrTag         = local.AppBattle
  ArgoCD_AppFileBranchOrTag           = local.AppFile
  ArgoCD_AppNFTBranchOrTag            = local.AppNFT
  ArgoCD_AppTableBranchOrTag          = local.AppTable
  ArgoCD_AppUserBranchOrTag           = local.AppUser
}



