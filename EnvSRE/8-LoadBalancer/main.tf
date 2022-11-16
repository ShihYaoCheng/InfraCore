# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/2.0.0"

  ProjectName = local.ProjectName

  DomainName = local.DomainName
  GameSubDomainNames = [local.GameSubDomainName]
  CDNSubDomainNames = [local.CDNSubDomainName]
  
  GodaddyAPIKey = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret

  ZoneTW = "asia-east1-c"
  ZoneEU = "europe-west2-c"
  
  providers = {
    kubernetes.tw = kubernetes.tw
    kubernetes.eu = kubernetes.eu
  }
}
