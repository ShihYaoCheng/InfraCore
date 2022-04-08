# https://artifacthub.io/packages/helm/traefik/traefik
# https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml
# helm upgrade --install traefik traefik/traefik -n traefik --create-namespace
resource "helm_release" "Traefik" {
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  version          = "~>10.19.4"
  create_namespace = true
  namespace        = "traefik"

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [
    templatefile("${path.module}/Values/traefik.yaml",
    {
      env-domain-name = var.RegisterDomainName ? var.DomainName : ""
    })
  ]
}

resource "helm_release" "TraefikResources" {
  depends_on = [helm_release.Traefik, helm_release.Prometheus]

  name             = "traefik-resources"
  chart            = "${path.module}/Charts/traefik-resources"
  namespace        = "traefik"
}