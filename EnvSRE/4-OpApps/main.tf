# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "OpApps" {
  source  = "../../Modules/OpApps/0.1.0"

  ProjectName = var.ProjectName

  RegisterDomainName = true
  DomainName = "sre.origingaia.com"
  GodaddyAPIKey = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret

  AlertSlackChannel          = "alert-sk-sre"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "20Gi"
  GrafanaAdminPassword       = "ran9977"
}



