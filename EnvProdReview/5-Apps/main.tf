# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Applications" {
  source = "../../Modules/Apps/0.3.0"

  ProjectName  = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPZone      = var.GCPZone

  ExternalDNS_Enable = false
  DomainName         = "v2.7.0.ponponsnake.com"
  GodaddyAPIKey      = ""
  GodaddyAPISecret   = ""

  CertManager_Enable         = true
  CertManager_CreateProdCert = true

  Prometheus_Enable            = true
  Prometheus_AlertSlackChannel = "alert-sk-prod-review"
  Prometheus_StorageClassName  = "ssd-delete"
  Prometheus_StorageSize       = "60Gi"
  Prometheus_Retention         = "30d"
  Grafana_AdminPassword        = "gra4422"

  CloudSQLProxy_Enable = true

  ArgoCD_Enable                       = true
  ArgoCD_EnableSelfHeal               = true
  ArgoCD_EnableAllApps                = true
  ArgoCD_EnableIngress                = true
  ArgoCD_IngressUseProdCert           = true
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



