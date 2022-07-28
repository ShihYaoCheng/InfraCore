# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps-Rel" {
  source = "../../Modules/Apps/1.0.0"

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

  ArgoCD_Enable               = true
  ArgoCD_EnableSelfHeal       = true
  ArgoCD_EnableIngress        = true
  ArgoCD_IngressUseProdCert   = true
  ArgoCD_SyncWindowTaipeiTime = "* * * * *"
  ArgoCD_GitLabTokenName      = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret    = var.ArgoCD_GitLabTokenSecret

  ArgoCD_EnableAppBackstage      = true
  ArgoCD_EnableAppBattle         = true
  ArgoCD_EnableAppFile           = true
  ArgoCD_EnableAppNFT            = true
  ArgoCD_EnableAppTable          = true
  ArgoCD_EnableAppUser           = true
  ArgoCD_AppBackstageBranchOrTag = "main"
  ArgoCD_AppBattleBranchOrTag    = "main"
  ArgoCD_AppFileBranchOrTag      = "main"
  ArgoCD_AppNFTBranchOrTag       = "main"
  ArgoCD_AppTableBranchOrTag     = "main"
  ArgoCD_AppUserBranchOrTag      = "main"
  ArgoCD_BackstageHelmValueFiles = "{values-main.yaml}"
  ArgoCD_BattleHelmValueFiles    = "{values-v2.7.0.yaml}"
  ArgoCD_FileHelmValueFiles      = "{values-v2.7.0.yaml}"
  ArgoCD_NFTHelmValueFiles       = "{values-beta.yaml}"
  ArgoCD_TableHelmValueFiles     = "{values-v2.7.0.yaml}"
  ArgoCD_UserHelmValueFiles      = "{values-v2.7.0.yaml}"

  ArgoCD_BackstageSqlPassword = "backstage1234"
  ArgoCD_UserSqlPassword      = "user1234"

  providers = {
    helm       = helm.rel
    kubernetes = kubernetes.rel
  }
}
