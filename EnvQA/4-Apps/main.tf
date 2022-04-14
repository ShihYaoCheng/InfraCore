# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "OpApps" {
  source = "../../Modules/Apps/0.1.0"

  ProjectName = var.ProjectName
  DomainName  = "qa.origingaia.com"

  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-prod.yaml}"
  ArgoCD_AppFileBranchOrTag           = "v0.0.9"
  ArgoCD_AppTableBranchOrTag          = "v0.0.3"
  ArgoCD_AppUserBranchOrTag           = "v0.0.4"
  ArgoCD_AppBattleBranchOrTag         = "v0.0.2f2"

  AlertSlackChannel          = "alert-sk-qa"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "20Gi"
  GrafanaAdminPassword       = var.GrafanaAdminPassword
}



