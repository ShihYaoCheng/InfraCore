module "infra" {
  source = "../EnvCore/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone

  ProjectEnvironment = "prod"

  GKEZones = ["asia-east1-a"]
  GKEMinNodeCount = 1
  GKEMaxNodeCount = 3

  GodaddyAPIKey          = "godaddy-api-key"
  GodaddyAPISecret       = "godaddy-api-secret"
  GodaddyDomainName      = "origingaia.com"
  AutoRegisterDomainName = false

  ArgoCD_EnableSelfHeal               = true
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-production.yaml}"
  ArgoCD_AppFileBranchOrTag = "v0.0.8f1"
  ArgoCD_AppTableBranchOrTag = "v0.0.2f1"
  ArgoCD_AppUserBranchOrTag = "v0.0.3f1"
  ArgoCD_AppBattleBranchOrTag = "v0.0.2f1"

  AlertSlackChannel = "alert-sk-production"
  GrafanaAdminPassword = var.GrafanaAdminPassword
  PrometheusStorageClassName = "ssd-retain"
  PrometheusStorageSize      = "500Gi"
}


