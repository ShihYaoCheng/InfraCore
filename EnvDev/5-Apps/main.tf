# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.3.0"

  ProjectName  = local.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPZone      = var.GCPZone

  DomainName                  = "dev.ponponsnake.com"
  CreateProductionCertificate = true

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = true
  ArgoCD_EnableAllApps                = true
  ArgoCD_EnableIngress                = true
  ArgoCD_UseProdCert                  = true
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-dev.yaml}"
  ArgoCD_AppBackstageBranchOrTag      = "main"
  ArgoCD_AppBattleBranchOrTag         = "main"
  ArgoCD_AppFileBranchOrTag           = "main"
  ArgoCD_AppNFTBranchOrTag            = "main"
  ArgoCD_AppTableBranchOrTag          = "main"
  ArgoCD_AppUserBranchOrTag           = "main"

  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  PrometheusRetention        = "60d"
  GrafanaAdminPassword       = "gra4422"
  AlertSlackChannel          = "alert-sk-dev"

  Velero_Enable = false
}



