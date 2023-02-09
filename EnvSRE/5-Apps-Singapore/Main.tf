# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "AppsSingapore" {
  source = "../../Modules/Apps/6.2.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = local.GCPZone

  GodaddyDomainName        = local.DomainName
  EnableGodaddyPlainDomain = true
  #  GodaddySubDomainNames = ["test", "test1", "www"]
  GodaddySubDomainNames    = local.SubDomainNames
  GodaddyAPIKey            = var.GodaddyAPIKey
  GodaddyAPISecret         = var.GodaddyAPISecret

  ArgoCD_OfficialWebRedirectEnabled  = true
  #  ArgoCD_OfficialWebRedirectDestFQDN = "www.origingaia.com"
  ArgoCD_OfficialWebRedirectDestFQDN = "www.${local.DomainName}"
  ArgoCD_OfficialWebCDNEnabled       = local.CDNEnabled
  ArgoCD_OfficialWebCDNUrl           = local.CDNUrlOfficial
  ArgoCD_OfficialKey                 = "official1234"
  ArgoCD_BackstageKey                = "backstage1234"

  CertManager_Enable         = true
  CertManager_CreateProdCert = false

  Prometheus_StorageClassName = "standard"
  Prometheus_StorageSize      = "20Gi"
  Prometheus_Retention        = "1d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName           = "sre-sg-dev"
  Robusta_SlackAPIKey           = var.Robusta_SlackAPIKey
  Robusta_SlackChannel          = "sk-sre-info"
  Robusta_NotifyDeploymentEvent = true

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = false
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = false
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
  ArgoCD_CqiPassword_Bcrypt = "$2a$10$vSB.qa1a05DVChv1XKLPxe2C/Om6xW1zFdWkFs9yOMVOOa2.hSX.i"

  providers = {
    helm       = helm.dev
    kubernetes = kubernetes.dev
  }
}

