# https://artifacthub.io/packages/helm/traefik/traefik
# https://github.com/traefik/traefik-helm-chart/blob/master/traefik/values.yaml
# helm upgrade --install traefik traefik/traefik -n traefik --create-namespace
# helm upgrade --install traefik traefik/traefik -n traefik --create-namespace --version 20.4.1 --set ingressClass.enabled=true --set ingressClass.isDefaultClass=true --set providers.kubernetesIngress.enabled=true
resource "helm_release" "Traefik" {
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  version          = "~>20.4.1"
  create_namespace = true
  namespace        = "traefik"
  
  # Add the Client IP to X-Forwarded-For header.
  set {
    name  = "service.spec.externalTrafficPolicy"
    value = "Local"
  }

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [templatefile("${path.module}/Values/Traefik.yaml", {})]
}