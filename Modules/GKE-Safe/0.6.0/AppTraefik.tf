# https://artifacthub.io/packages/helm/traefik/traefik
# https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml
# helm upgrade --install traefik traefik/traefik -n traefik --create-namespace
resource "helm_release" "Traefik" {
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  version          = "~>15.0.0"
  create_namespace = true
  namespace        = "traefik"

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [templatefile("${path.module}/Values/Traefik.yaml", {})]
}