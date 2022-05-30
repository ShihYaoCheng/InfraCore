# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.1.0"

  ProjectName  = var.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPZone      = var.GCPZone

  DomainName                  = "dev.ponponsnake.com"
  CreateProductionCertificate = true

  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-dev.yaml}"
  ArgoCD_AppFileBranchOrTag           = "main"
  ArgoCD_AppTableBranchOrTag          = "main"
  ArgoCD_AppUserBranchOrTag           = "main"
  ArgoCD_AppBackstageBranchOrTag      = "main"
  ArgoCD_AppBattleBranchOrTag         = "main"

  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  GrafanaAdminPassword       = "gra4422"
  AlertSlackChannel          = "alert-sk-dev"

  Velero_Enable = false
}



