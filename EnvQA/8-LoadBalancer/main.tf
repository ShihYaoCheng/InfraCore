# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/1.1.0"

  ProjectName  = local.ProjectName
  
  GodaddyAPIKey        = var.GodaddyAPIKey
  GodaddyAPISecret     = var.GodaddyAPISecret
  GodaddyDomainName    = local.DomainName
  GodaddySubDomainName = local.SubDomainName

  ZoneTW = "asia-east1-a"
  ZoneEU = "europe-west2-a"

  providers = {
    kubernetes.tw = kubernetes.tw
    kubernetes.eu = kubernetes.eu
  }
}



