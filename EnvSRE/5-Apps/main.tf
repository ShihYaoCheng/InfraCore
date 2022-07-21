# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps-Dev" {
  source = "../../Modules/Apps/0.6.0"

  ProjectName  = local.ProjectName
  UniqueName   = "Taiwan-Dev"
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = true
  DomainName         = "test.origingaia.com"
  GodaddyAPIKey      = var.GodaddyAPIKey
  GodaddyAPISecret   = var.GodaddyAPISecret

  CertManager_Enable         = true
  CertManager_CreateProdCert = false

  Prometheus_StorageClassName = "ssd-delete"
  Prometheus_StorageSize      = "20Gi"
  Prometheus_Retention        = "1d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName  = "sre-tw-dev"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-sre-info"

  CloudSQLProxy_Enable = true

  ArgoCD_Enable                  = true
  ArgoCD_EnableSelfHeal          = false
  ArgoCD_EnableAllApps           = true
  ArgoCD_EnableIngress           = true
  ArgoCD_IngressUseProdCert      = false
  ArgoCD_GitLabTokenName         = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret       = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowTaipeiTime    = "* * * * *"
  ArgoCD_AppFileBranchOrTag      = "main"
  ArgoCD_AppTableBranchOrTag     = "main"
  ArgoCD_AppUserBranchOrTag      = "main"
  ArgoCD_AppBackstageBranchOrTag = "main"
  ArgoCD_AppBattleBranchOrTag    = "main"
  ArgoCD_AppNFTBranchOrTag       = "main"
  ArgoCD_BackstageHelmValueFiles = "{values-sre.yaml}"
  ArgoCD_BattleHelmValueFiles    = "{values-sre.yaml}"
  ArgoCD_FileHelmValueFiles      = "{values-sre.yaml}"
  ArgoCD_NFTHelmValueFiles       = "{values-sre.yaml}"
  ArgoCD_TableHelmValueFiles     = "{values-sre.yaml}"
  ArgoCD_UserHelmValueFiles      = "{values-sre.yaml}"

  providers = {
    helm       = helm.dev
    kubernetes = kubernetes.dev
  }
}

#module "Apps-Rel" {
#  source = "../../Modules/Apps/0.5.0"
#
#  ProjectName  = local.ProjectName
#  UniqueName   = "Taiwan-Release"
#  GCPProjectID = local.ProjectID
#  GCPZone      = "asia-east1-b"
#
#  ExternalDNS_Enable = true
#  DomainName         = "release.origingaia.com"
#  GodaddyAPIKey      = var.GodaddyAPIKey
#  GodaddyAPISecret   = var.GodaddyAPISecret
#
#  CertManager_Enable         = true
#  CertManager_CreateProdCert = false
#
#  Prometheus_StorageClassName = "ssd-delete"
#  Prometheus_StorageSize      = "20Gi"
#  Prometheus_Retention        = "1d"
#  Grafana_AdminPassword       = "gra4422"
#
#  Robusta_ClusterName  = "sre-tw-release"
#  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
#  Robusta_SlackChannel = "sk-sre-info"
#
#  CloudSQLProxy_Enable = true
#
#  ArgoCD_Enable                  = true
#  ArgoCD_EnableSelfHeal          = false
#  ArgoCD_EnableAllApps           = true
#  ArgoCD_EnableIngress           = true
#  ArgoCD_IngressUseProdCert      = false
#  ArgoCD_GitLabTokenName         = var.ArgoCD_GitLabTokenName
#  ArgoCD_GitLabTokenSecret       = var.ArgoCD_GitLabTokenSecret
#  ArgoCD_SyncWindowTaipeiTime    = "* * * * *"
#  ArgoCD_AppFileBranchOrTag      = "main"
#  ArgoCD_AppTableBranchOrTag     = "main"
#  ArgoCD_AppUserBranchOrTag      = "main"
#  ArgoCD_AppBackstageBranchOrTag = "main"
#  ArgoCD_AppBattleBranchOrTag    = "main"
#  ArgoCD_AppNFTBranchOrTag       = "main"
#  ArgoCD_BackstageHelmValueFiles = "{values-sre.yaml}"
#  ArgoCD_BattleHelmValueFiles    = "{values-sre.yaml}"
#  ArgoCD_FileHelmValueFiles      = "{values-sre.yaml}"
#  ArgoCD_NFTHelmValueFiles       = "{values-sre.yaml}"
#  ArgoCD_TableHelmValueFiles     = "{values-sre.yaml}"
#  ArgoCD_UserHelmValueFiles      = "{values-sre.yaml}"
#
#  providers = {
#    helm       = helm.rel
#    kubernetes = kubernetes.rel
#  }
#}

