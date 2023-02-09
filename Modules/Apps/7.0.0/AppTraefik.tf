resource "helm_release" "TraefikResources" {
  depends_on = [helm_release.Robusta]

  name             = "traefik-resources"
  chart            = "${path.module}/Charts/traefik-resources"
  namespace        = "traefik"
}

data "kubernetes_service" "traefik" {
  metadata {
    name = "traefik"
    namespace = "traefik"
  }
}

resource "helm_release" "Godaddy" {
  name             = "godaddy-traefik"
  chart            = "${path.module}/Charts/Godaddy"
  namespace        = "default"
  
  set {
    name  = "domainName"
    value = var.GodaddyDomainName
  }

  set {
    name  = "enablePlainSubDomainName"
    value = var.EnableGodaddyPlainDomain
  }

  set {
    name  = "subDomainNames"
    value = local.SubDomainsForGodaddyHelmValues
  }
  
  set {
    name  = "ip"
    value = data.kubernetes_service.traefik.status.0.load_balancer.0.ingress.0.ip
  }
  
  set_sensitive {
    name  = "godaddy.key"
    value = var.GodaddyAPIKey
  }

  set_sensitive {
    name  = "godaddy.secret"
    value = var.GodaddyAPISecret
  }
}