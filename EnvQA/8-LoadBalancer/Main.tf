# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/2.1.0"

  ProjectName  = local.ProjectName
  
  GodaddyAPIKey        = var.GodaddyAPIKey
  GodaddyAPISecret     = var.GodaddyAPISecret

  DomainName         = local.DomainName
  GameSubDomainNames = [local.GameSubDomainName]

  CDNEnabled         = local.CDNEnabled
  CDNSubDomainNames  = [local.CDNSubDomainName]
  CDNUrlPathOfficial = local.CDNUrlPathOfficial
  
  ZoneTW = "asia-east1-a"
  ZoneEU = "europe-west2-a"

  providers = {
    kubernetes.tw = kubernetes.tw
    kubernetes.eu = kubernetes.eu
  }
}



