# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.5.0"

  ProjectName  = local.ProjectName
  UniqueName   = "TW-Dev"
  GCPProjectID = local.ProjectID
  GCPZone      = "asia-east1-a"

  ExternalDNS_Enable = false
  DomainName         = "dev.ponponsnake.com"
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  CloudSQLProxy_Enable = true

  Prometheus_StorageClassName = "ssd-delete"
  Prometheus_StorageSize      = "100Gi"
  Prometheus_Retention        = "60d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName  = "sk-dev"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-dev-info"

  ArgoCD_Enable                  = true
  ArgoCD_EnableSelfHeal          = true
  ArgoCD_EnableAllApps           = true
  ArgoCD_EnableIngress           = true
  ArgoCD_IngressUseProdCert      = true
  ArgoCD_SyncWindowTaipeiTime    = "* * * * *"
  ArgoCD_GitLabTokenName         = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret       = var.ArgoCD_GitLabTokenSecret
  ArgoCD_AppBackstageBranchOrTag = "main"
  ArgoCD_AppBattleBranchOrTag    = "main"
  ArgoCD_AppFileBranchOrTag      = "main"
  ArgoCD_AppNFTBranchOrTag       = "main"
  ArgoCD_AppTableBranchOrTag     = "main"
  ArgoCD_AppUserBranchOrTag      = "main"
  ArgoCD_BackstageHelmValueFiles = "{values-dev.yaml}"
  ArgoCD_BattleHelmValueFiles    = "{values-dev.yaml}"
  ArgoCD_FileHelmValueFiles      = "{values-dev.yaml}"
  ArgoCD_NFTHelmValueFiles       = "{values-dev.yaml}"
  ArgoCD_TableHelmValueFiles     = "{values-dev.yaml}"
  ArgoCD_UserHelmValueFiles      = "{values-dev.yaml}"

  providers = {
    helm       = helm.dev
    kubernetes = kubernetes.dev
  }
}


module "Apps-Rel" {
  source = "../../Modules/Apps/0.5.0"

  ProjectName  = local.ProjectName
  UniqueName   = "TW-Rel"
  GCPProjectID = local.ProjectID
  GCPZone      = "asia-east1-b"

  ExternalDNS_Enable = false
  DomainName         = "rel.ponponsnake.com"
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  CloudSQLProxy_Enable = true

  Prometheus_StorageClassName = "ssd-delete"
  Prometheus_StorageSize      = "100Gi"
  Prometheus_Retention        = "60d"
  Grafana_AdminPassword       = "gra4422"

  Robusta_ClusterName  = "sk-rel"
  Robusta_SlackAPIKey  = var.Robusta_SlackAPIKey
  Robusta_SlackChannel = "sk-rel-info"

  ArgoCD_Enable                  = true
  ArgoCD_EnableSelfHeal          = true
  ArgoCD_EnableAllApps           = true
  ArgoCD_EnableIngress           = true
  ArgoCD_IngressUseProdCert      = true
  ArgoCD_SyncWindowTaipeiTime    = "* * * * *"
  ArgoCD_GitLabTokenName         = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret       = var.ArgoCD_GitLabTokenSecret
  ArgoCD_AppBackstageBranchOrTag = "main"
  ArgoCD_AppBattleBranchOrTag    = "main"
  ArgoCD_AppFileBranchOrTag      = "main"
  ArgoCD_AppNFTBranchOrTag       = "main"
  ArgoCD_AppTableBranchOrTag     = "main"
  ArgoCD_AppUserBranchOrTag      = "main"
  ArgoCD_BackstageHelmValueFiles = "{values-v2.7.0.yaml}"
  ArgoCD_BattleHelmValueFiles    = "{values-v2.7.0.yaml}"
  ArgoCD_FileHelmValueFiles      = "{values-v2.7.0.yaml}"
  ArgoCD_NFTHelmValueFiles       = "{values-v2.7.0.yaml}"
  ArgoCD_TableHelmValueFiles     = "{values-v2.7.0.yaml}"
  ArgoCD_UserHelmValueFiles      = "{values-v2.7.0.yaml}"

  providers = {
    helm       = helm.rel
    kubernetes = kubernetes.rel
  }
}
