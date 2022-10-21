# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsEu" {
  source = "../../Modules/Apps/3.0.1"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  GodaddyDomainName                  = "origingaia.com"
  GodaddySubDomainName1              = "eu.test"
  GodaddySubDomainName2              = ""
  GodaddyAPIKey                      = var.GodaddyAPIKey
  GodaddyAPISecret                   = var.GodaddyAPISecret
  ArgoCD_OfficialWebRedirectEnabled  = false
  ArgoCD_OfficialWebRedirectSrcFQDN  = ""
  ArgoCD_OfficialWebRedirectDestFQDN = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = false

  Prometheus_StorageClassName = "standard"
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
  ArgoCD_BattleHelmValueFiles      = "{values-sre.yaml\\, EnableNEG.yaml}"
  ArgoCD_FileHelmValueFiles        = "{values-sre.yaml\\, EnableNEG.yaml}"
  ArgoCD_NFTHelmValueFiles         = "{values-sre.yaml}"
  ArgoCD_TableHelmValueFiles       = "{values-sre.yaml}"
  ArgoCD_UserHelmValueFiles        = "{values-sre.yaml}"
  ArgoCD_OfficialWebHelmValueFiles = "{values-sre.yaml}"

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"
}



