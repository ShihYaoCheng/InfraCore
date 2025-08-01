﻿# https://github.com/robusta-dev/robusta/blob/master/helm/robusta/values.yaml
# helm upgrade --install robusta robusta/robusta -f ./Values/Robusta.yaml -n robusta --create-namespace
# helm uninstall robusta -n robusta
resource "helm_release" "Robusta" {
  depends_on = [helm_release.Configuration]
  
  name             = "robusta"
  repository       = "https://robusta-charts.storage.googleapis.com"
  chart            = "robusta"
  version          = "~>0.9.17"
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
    })
  ]
}

resource "helm_release" "PrometheusResources" {
  depends_on = [helm_release.Robusta, helm_release.Traefik]

  name             = "prometheus-stack-resources"
  chart            = "${path.module}/Charts/prometheus-stack-resources"
  namespace        = "robusta"

  set {
    name  = "grafana.ingress.useProductionCert"
    value = var.CertManager_CreateProdCert
  }
}