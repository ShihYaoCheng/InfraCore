# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Apps" {
  source = "../../Modules/Apps/0.2.0"

  ProjectName  = local.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable          = false
  DomainName                  = ""
  CreateProductionCertificate = false

  CertManager_Enable   = false
  CloudSQLProxy_Enable = false
  Velero_Enable = false

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = true
  ArgoCD_EnableAllApps                = false
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_RepositoryHelmPathValueFiles = "{values-prod.yaml}"
  ArgoCD_AppBackstageBranchOrTag      = ""
  ArgoCD_AppBattleBranchOrTag         = "v2.6.0C7"
  ArgoCD_AppFileBranchOrTag           = "v2.6.0C7"
  ArgoCD_AppNFTBranchOrTag            = ""
  ArgoCD_AppTableBranchOrTag          = ""
  ArgoCD_AppUserBranchOrTag           = ""

  AlertSlackChannel          = "alert-sk-qa"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  PrometheusRetention        = "60d"
  GrafanaAdminPassword       = var.GrafanaAdminPassword
}



