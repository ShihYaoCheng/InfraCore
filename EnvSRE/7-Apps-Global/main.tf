# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsEu" {
  source = "../../Modules/Apps/1.2.1"

  ProjectName  = local.ProjectName
  UniqueName   = "eu"
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = false
  DomainName         = "eu.test.origingaia.com"
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = false

  CloudSQLProxy_Enable = false

  Prometheus_StorageClassName = "ssd-delete"
  Prometheus_StorageSize      = "20Gi"
  Prometheus_Retention        = "1d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName           = "sre-eu"
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

  ArgoCD_BackstageHelmValueFiles   = "{values-sre.yaml}"
  ArgoCD_BattleHelmValueFiles      = "{values-sre.yaml\\, template-values-neg.yaml}"
  ArgoCD_FileHelmValueFiles        = "{values-sre.yaml\\, template-values-neg.yaml}"
  ArgoCD_NFTHelmValueFiles         = "{values-sre.yaml}"
  ArgoCD_TableHelmValueFiles       = "{values-sre.yaml}"
  ArgoCD_UserHelmValueFiles        = "{values-sre.yaml}"
  ArgoCD_OfficialWebHelmValueFiles = "{values-sre.yaml}"

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"
}



