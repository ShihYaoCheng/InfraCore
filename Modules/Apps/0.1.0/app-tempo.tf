# https://artifacthub.io/packages/helm/grafana/tempo
# https://artifacthub.io/packages/helm/grafana/tempo-distributed
# https://github.com/grafana/helm-charts/blob/main/charts/tempo/values.yaml
# helm repo add grafana https://grafana.github.io/helm-charts
# helm upgrade --install tempo grafana/tempo -n tempo --create-namespace
# helm uninstall tempo -n tempo
resource "helm_release" "Tempo" {
  count = var.Tempo_Enable ? 1 : 0
  
  depends_on = [helm_release.Prometheus]

  name             = "tempo"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "tempo"
  version          = "~>0.14.2"
  namespace        = "tempo"
  create_namespace = true

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
    values = [
      templatefile("${path.module}/Values/tempo.yaml", {})
    ]
}

