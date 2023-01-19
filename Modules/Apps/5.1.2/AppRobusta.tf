# https://github.com/robusta-dev/robusta/blob/master/helm/robusta/values.yaml
# helm upgrade --install robusta robusta/robusta -f ./Values/Robusta.yaml -n robusta --create-namespace
# helm uninstall robusta -n robusta
# https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
# https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
# https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#kube-prometheus-stack
# https://github.com/prometheus-operator/kube-prometheus
resource "helm_release" "Robusta" {
  name             = "robusta"
  repository       = "https://robusta-charts.storage.googleapis.com"
  chart            = "robusta"
#  version          = "~>0.10.8"
  version          = "0.10.10"
  namespace        = "robusta"

  values = [
    templatefile("${path.module}/Values/Robusta.yaml", {
      slackChannel = var.Robusta_SlackChannel,
      slackAPIKey = var.Robusta_SlackAPIKey,
      clusterName = var.Robusta_ClusterName,
      grafanaAdminPassword = var.Grafana_AdminPassword,
      prometheusStorageClassName = var.Prometheus_StorageClassName,
      prometheusStorageSize = var.Prometheus_StorageSize,
      prometheusRetention = var.Prometheus_Retention
    }),
    
    var.Robusta_NotifyDeploymentEvent 
    ? templatefile("${path.module}/Values/Robusta-CustomPlaybook.yaml", {}) 
    : templatefile("${path.module}/Values/Robusta-CustomPlaybook-Empty.yaml", {})
  ]
  
}

resource "helm_release" "PrometheusResources" {
  depends_on = [helm_release.Robusta]

  name             = "prometheus-stack-resources"
  chart            = "${path.module}/Charts/prometheus-stack-resources"
  namespace        = "robusta"

  set {
    name  = "grafana.ingress.useProductionCert"
    value = var.CertManager_CreateProdCert
  }
}