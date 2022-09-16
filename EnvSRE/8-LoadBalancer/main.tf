# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/1.0.0"

  ProjectName = local.ProjectName

  GodaddyDomainName = "origingaia.com"
  GodaddySubDomainName = "global"
  GodaddyAPIKey = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret

  ZoneTW = "asia-east1-c"
  ZoneEU = "europe-west2-c"
  
  providers = {
    kubernetes.tw = kubernetes.tw
    kubernetes.eu = kubernetes.eu
  }
}
