# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.1.0"

  ProjectName  = var.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPZone      = var.GCPZone

  DomainName                  = "qa.ponponsnake.com"
  CreateProductionCertificate = true

  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-prod.yaml}"
  ArgoCD_AppBackstageBranchOrTag      = "v0.3.0f2"
  ArgoCD_AppBattleBranchOrTag         = "v0.3.0f3"
  ArgoCD_AppFileBranchOrTag           = "v0.3.0f2"
  ArgoCD_AppNFTBranchOrTag            = "v0.3.0"
  ArgoCD_AppTableBranchOrTag          = "v0.3.0f1"
  ArgoCD_AppUserBranchOrTag           = "v0.3.0f1"

  AlertSlackChannel          = "alert-sk-qa"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  PrometheusRetention        = "60d"
  GrafanaAdminPassword       = var.GrafanaAdminPassword

  Velero_Enable = false
}



