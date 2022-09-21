# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/2.1.0"

  ProjectName  = local.ProjectName
  UniqueName   = "TW-Dev"
  GCPProjectID = local.ProjectID
  GCPZone      = "asia-east1-a"

  GodaddyDomainName                  = "origingaia.com"
  GodaddySubDomainName1              = "dev"
  GodaddySubDomainName2              = ""
  GodaddyAPIKey                      = var.GodaddyAPIKey
  GodaddyAPISecret                   = var.GodaddyAPISecret
  ArgoCD_OfficialWebRedirectEnabled = false
  ArgoCD_OfficialWebRedirectDestFQDN = ""
  ArgoCD_OfficialWebRedirectSrcFQDN  = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  CloudSQLProxy_Enable = true

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "100Gi"
  Prometheus_Retention        = "60d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName           = "sk-dev"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-dev-info"
  Robusta_NotifyDeploymentEvent = false

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = true
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = true
  ArgoCD_SyncWindowTaipeiTime = "* * * * *"
  ArgoCD_GitLabTokenName      = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret    = var.ArgoCD_GitLabTokenSecret

  ArgoCD_EnableAppBackstage   = true
  ArgoCD_EnableAppBattle      = true
  ArgoCD_EnableAppFile        = true
  ArgoCD_EnableAppNFT         = true
  ArgoCD_EnableAppTable       = true
  ArgoCD_EnableAppUser        = true
  ArgoCD_EnableAppOfficialWeb = true

  ArgoCD_AppBackstageBranchOrTag   = "main"
  ArgoCD_AppBattleBranchOrTag      = "main"
  ArgoCD_AppFileBranchOrTag        = "main"
  ArgoCD_AppNFTBranchOrTag         = "main"
  ArgoCD_AppTableBranchOrTag       = "main"
  ArgoCD_AppUserBranchOrTag        = "main"
  ArgoCD_AppOfficialWebBranchOrTag = "main"

  ArgoCD_BackstageHelmValueFiles   = "{values-main.yaml}"
  ArgoCD_BattleHelmValueFiles      = "{values-main.yaml}"
  ArgoCD_FileHelmValueFiles        = "{values-main.yaml}"
  ArgoCD_NFTHelmValueFiles         = "{values-main.yaml}"
  ArgoCD_TableHelmValueFiles       = "{values-main.yaml}"
  ArgoCD_UserHelmValueFiles        = "{values-main.yaml}"
  ArgoCD_OfficialWebHelmValueFiles = "{values-main.yaml}"

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"

  providers = {
    helm       = helm.dev
    kubernetes = kubernetes.dev
  }
}
