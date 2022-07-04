# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/0.2.0"

  ProjectName  = local.ProjectName
  
  LoadBalancerDomainName = "global.prod.ponponsnake.com"

  ZoneTW = "asia-east1-a"
  ZoneEU = "europe-west2-a"

  providers = {
    kubernetes.tw = kubernetes.tw
    kubernetes.eu = kubernetes.eu
  }
}



