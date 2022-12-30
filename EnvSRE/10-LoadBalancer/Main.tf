# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/4.0.0"

  ProjectName = local.ProjectName

  DomainName         = local.DomainName
  GameSubDomainNames = [local.GameSubDomainName]

  CDNEnabled         = local.CDNEnabled
  CDNSubDomainNames  = [local.CDNSubDomainName]
  CDNUrlPathOfficial = local.CDNUrlPathOfficial

  GodaddyAPIKey    = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret

  ZoneLondon = local.ZoneLondon
  ZoneSingapore = local.ZoneSingapore
  ZoneLosAngeles = local.ZoneLosAngeles

  providers = {
    kubernetes.london = kubernetes.london
    kubernetes.singapore = kubernetes.singapore
    kubernetes.la = kubernetes.la
  }
}
