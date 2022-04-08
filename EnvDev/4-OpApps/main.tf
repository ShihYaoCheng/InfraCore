# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "OpApps" {
  source  = "../../Modules/OpApps/0.1.0"

  ProjectName = "cqi-sk-dev"
  DomainName = "dev.origingaia.com"

  AlertSlackChannel          = "alert-sk-dev"
  PrometheusStorageClassName = "ssd-delete"
  PrometheusStorageSize      = "100Gi"
  GrafanaAdminPassword       = "ran9977"
}



