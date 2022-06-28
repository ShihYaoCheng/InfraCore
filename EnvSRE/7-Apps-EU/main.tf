# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Applications" {
  source = "../../Modules/Apps/0.3.0"

  ProjectName  = local.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable          = false
  DomainName                  = ""
  CreateProductionCertificate = false

  CertManager_Enable   = false
  CloudSQLProxy_Enable = false
  Velero_Enable        = false

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = false
  ArgoCD_EnableAllApps                = false
  ArgoCD_EnableIngress                = false
  ArgoCD_UseProdCert                  = false
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



