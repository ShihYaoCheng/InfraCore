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

  Prometheus_Enable            = true
  Prometheus_AlertSlackChannel = "alert-sk-prod-review"
  Prometheus_StorageClassName  = "ssd-delete"
  Prometheus_StorageSize       = "60Gi"
  Prometheus_Retention         = "30d"
  Grafana_AdminPassword        = "gra4422"

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = true
  ArgoCD_EnableAllApps                = false
  ArgoCD_EnableIngress                = false
  ArgoCD_IngressUseProdCert           = false
  ArgoCD_GitLabTokenName              = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret            = var.ArgoCD_GitLabTokenSecret
  ArgoCD_SyncWindowCronTime           = "* * * * *"
  ArgoCD_RepositoryHelmPathValueFiles = "{values-prod.yaml}"
  ArgoCD_AppBackstageBranchOrTag      = "v2.6.0C6"
  ArgoCD_AppBattleBranchOrTag         = "v2.6.0C7F2"
  ArgoCD_AppFileBranchOrTag           = "v2.6.0C7"
  ArgoCD_AppNFTBranchOrTag            = "v2.6.0C2F1"
  ArgoCD_AppTableBranchOrTag          = "v2.6.0C6"
  ArgoCD_AppUserBranchOrTag           = "v2.6.0C6F1"
}



