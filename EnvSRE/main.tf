module "infra" {
  source = "../EnvCore/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion    = var.GCPRegion
  GCPZone      = var.GCPZone

  ProjectEnvironment = "sre"

  GKEZones     = ["asia-east1-a"]
  GKENodeCount = 2

  GodaddyAPIKey          = var.GodaddyAPIKey
  GodaddyAPISecret       = var.GodaddyAPISecret
  GodaddyDomainName      = "origingaia.com"
  AutoRegisterDomainName = true

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = false
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-sre.yaml}"
  ArgoCD_AppFileBranchOrTag           = "main"
  ArgoCD_AppTableBranchOrTag          = "main"
  ArgoCD_AppUserBranchOrTag           = "main"
  ArgoCD_AppBattleBranchOrTag         = "main"

  AlertSlackChannel          = "alert-sk-sre"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "20Gi"
  GrafanaAdminPassword       = "ran9977"
}


