# https://artifacthub.io/packages/helm/traefik/traefik
# https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml
# helm upgrade --install traefik traefik/traefik -n traefik --create-namespace
resource "helm_release" "traefik" {
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  version          = "~>10.14.2"
  create_namespace = true
  namespace        = "traefik"

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [
    templatefile("${path.module}/values/traefik.yaml",
    {
      env-domain-name = var.AutoRegisterDomainName ? local.EnvDomainName : ""
    })
  ]
}

resource "helm_release" "traefik-resources" {
  depends_on = [helm_release.traefik, helm_release.prometheus]

  name             = "traefik-resources"
  chart            = "../charts/traefik-resources"
  namespace        = "traefik"
}