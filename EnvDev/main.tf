module "infra" {
  source = "../EnvCore/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  ProjectEnvironment = "dev"

  GKEMinNodeCount = 1
  GKEMaxNodeCount = 3

  ArgoCD_GitLabTokenName = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-dev.yaml}"

  AlertSlackChannel = "alert-sk-sre"
  PrometheusStorageClassName = "ssd-delete"
  GrafanaAdminPassword = "admin1234"
}


