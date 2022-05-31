# https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
# https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
# https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#kube-prometheus-stack
# https://github.com/prometheus-operator/kube-prometheus
# kubectl create ns monitoring && kubectl label ns monitoring kubed=sync
# helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring --create-namespace -f values/prometheus-stack.yaml -f values/prometheus-stack-alerts.yaml --set slackChannel=
# helm uninstall kube-prometheus-stack -n monitoring
resource "helm_release" "Prometheus" {
  count = var.Prometheus_Enable ? 1 : 0
  
  depends_on = [helm_release.Configuration]

  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "~>34.9.0"
  namespace        = "monitoring"

  values = [
    templatefile("${path.module}/Values/prometheus-stack.yaml",
    {
      slackChannel = var.AlertSlackChannel,
      prometheusStorageClassName = var.PrometheusStorageClassName,
      prometheusStorageSize = var.PrometheusStorageSize,
      prometheusRetention = var.PrometheusRetention,
      grafanaAdminPassword = var.GrafanaAdminPassword
    }),

    templatefile("${path.module}/Values/prometheus-stack-alerts.yaml", {})
  ]
}

resource "helm_release" "PrometheusResources" {
  depends_on = [helm_release.Prometheus, helm_release.Traefik]

  name             = "prometheus-stack-resources"
  chart            = "${path.module}/Charts/prometheus-stack-resources"
  namespace        = "monitoring"
  
  set {
    name  = "grafana.ingress.useProductionCert"
    value = var.CreateProductionCertificate
  }
}
