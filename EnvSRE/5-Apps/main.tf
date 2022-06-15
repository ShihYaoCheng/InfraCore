# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Applications" {
  source = "../../Modules/Apps/0.1.0"

  ProjectName  = var.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable          = true
  DomainName                  = "sre.origingaia.com"
  CreateProductionCertificate = false
  GodaddyAPIKey               = var.GodaddyAPIKey
  GodaddyAPISecret            = var.GodaddyAPISecret

  ArgoCD_Enable                       = false
  ArgoCD_EnableSelfHeal               = false
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-sre.yaml}"
  ArgoCD_AppFileBranchOrTag           = "main"
  ArgoCD_AppTableBranchOrTag          = "main"
  ArgoCD_AppUserBranchOrTag           = "main"
  ArgoCD_AppBackstageBranchOrTag      = "main"
  ArgoCD_AppBattleBranchOrTag         = "main"
  ArgoCD_AppNFTBranchOrTag            = "main"

  AlertSlackChannel          = "alert-sk-sre"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "20Gi"
  PrometheusRetention        = "1d"
  GrafanaAdminPassword       = "gra4422"
}



