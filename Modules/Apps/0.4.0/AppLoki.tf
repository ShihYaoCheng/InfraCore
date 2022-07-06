
data "google_storage_bucket_object_content" "LokiServiceAccountKey" {
  bucket = var.ProjectName
  name   = "LokiServiceAccountKey"
}

resource "helm_release" "LokiResourcesPre" {
  count = var.Loki_Enable ? 1 : 0
  
  name             = "loki-resources-pre"
  chart            = "${path.module}/Charts/loki-resources-pre"
  namespace        = "loki"
  create_namespace = true

  set_sensitive {
    name  = "gcs_service_account_base64"
    value = var.Loki_Enable ? base64encode(data.google_storage_bucket_object_content.LokiServiceAccountKey.content) : ""
  }
}

# https://artifacthub.io/packages/helm/grafana/loki-stack
# https://github.com/grafana/helm-charts/tree/main/charts/loki-stack
# https://github.com/grafana/helm-charts/blob/main/charts/loki-stack/values.yaml
# https://github.com/grafana/helm-charts/blob/main/charts/loki/values.yaml
resource "helm_release" "Loki" {
  count = var.Loki_Enable ? 1 : 0
  
  depends_on = [helm_release.LokiResourcesPre, helm_release.Robusta]

  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki-stack"
  version          = "~>2.6.4"
  namespace        = "loki"
  create_namespace = true

  values = [
    templatefile("${path.module}/Values/loki.yaml",
    {
      bucket-name = "${var.ProjectName}-loki"
    })
  ]
}

