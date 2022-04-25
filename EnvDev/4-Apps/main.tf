# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "OpApps" {
  source  = "../../Modules/Apps/0.1.0"

  ProjectName = var.ProjectName
  DomainName = "dev.origingaia.com"

  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-dev.yaml}"
  ArgoCD_AppFileBranchOrTag           = "main"
  ArgoCD_AppTableBranchOrTag          = "main"
  ArgoCD_AppUserBranchOrTag           = "main"
  ArgoCD_AppBattleBranchOrTag         = "main"

  Prometheus_Enable = false
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  GrafanaAdminPassword       = "ran9977"

  AlertSlackChannel          = "alert-sk-dev"
  
  Loki_Enable = false
  Tempo_Enable = false
  Velero_Enable = false
}



