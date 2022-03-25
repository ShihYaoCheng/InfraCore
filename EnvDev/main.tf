module "infra" {
  source = "../EnvCore/0.1.0"

  GCPProjectID       = var.GCPProjectID
  GCPRegion          = var.GCPRegion
  GCPZone            = var.GCPZone
  ProjectEnvironment = "dev"

  GKEZones        = ["asia-east1-a"]
  GKEMinNodeCount = 1
  GKEMaxNodeCount = 3

  GodaddyAPIKey          = "godaddy-api-key"
  GodaddyAPISecret       = "godaddy-api-secret"
  GodaddyDomainName      = "origingaia.com"
  AutoRegisterDomainName = false

  ArgoCD_EnableSelfHeal               = true
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-dev.yaml}"
  ArgoCD_AppFileBranchOrTag = "main"
  ArgoCD_AppTableBranchOrTag = "main"
  ArgoCD_AppUserBranchOrTag = "main"
  ArgoCD_AppBattleBranchOrTag = "main"

  AlertSlackChannel          = "alert-sk-dev"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  GrafanaAdminPassword       = "ran9977"
}


