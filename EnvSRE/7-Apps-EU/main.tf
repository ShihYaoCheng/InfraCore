# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Applications" {
  source = "../../Modules/Apps/0.3.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = false
  DomainName         = ""
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = false
  CertManager_CreateProdCert = false

  CloudSQLProxy_Enable = false

  Prometheus_AlertSlackChannel = "alert-sk-sre"
  Prometheus_StorageClassName  = "ssd-delete"
  Prometheus_StorageSize       = "20Gi"
  Prometheus_Retention         = "1d"
  Grafana_AdminPassword        = "gra4422"

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = false
  ArgoCD_EnableAllApps                = false
  ArgoCD_EnableIngress                = false
  ArgoCD_IngressUseProdCert           = false
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowCronTime           = "* * * * *"
  ArgoCD_RepositoryHelmPathValueFiles = "{values-sre.yaml}"
  ArgoCD_AppFileBranchOrTag           = "main"
  ArgoCD_AppTableBranchOrTag          = "main"
  ArgoCD_AppUserBranchOrTag           = "main"
  ArgoCD_AppBackstageBranchOrTag      = "main"
  ArgoCD_AppBattleBranchOrTag         = "main"
  ArgoCD_AppNFTBranchOrTag            = "main"
}



