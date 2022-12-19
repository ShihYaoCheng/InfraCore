# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/3.0.0-lack-singapore"

  ProjectName = local.ProjectName

  DomainName         = local.DomainName
  GameSubDomainNames = [local.GameSubDomainName]

  CDNEnabled         = local.CDNEnabled
  CDNSubDomainNames  = [local.CDNSubDomainName]
  CDNUrlPathOfficial = local.CDNUrlPathOfficial

  GodaddyAPIKey    = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret

  ZoneTaiwan = local.ZoneTaiwan
  ZoneLondon = local.ZoneLondon
  ZoneSingapore = local.ZoneSingapore
  ZoneLosAngeles = local.ZoneLosAngeles

  providers = {
    kubernetes.taiwan = kubernetes.taiwan
    kubernetes.london = kubernetes.london
#    kubernetes.singapore = kubernetes.singapore
    kubernetes.la = kubernetes.la
  }
}
