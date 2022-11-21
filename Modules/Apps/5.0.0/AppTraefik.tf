# https://artifacthub.io/packages/helm/traefik/traefik
# https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml
# helm upgrade --install traefik traefik/traefik -n traefik --create-namespace
#resource "helm_release" "Traefik" {
#  name             = "traefik"
#  repository       = "https://helm.traefik.io/traefik"
#  chart            = "traefik"
#  version          = "~>10.24.3"
#  create_namespace = true
#  namespace        = "traefik"
#
#  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
#  values = [templatefile("${path.module}/Values/traefik.yaml", {})]
#}

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