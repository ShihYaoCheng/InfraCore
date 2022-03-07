# https://artifacthub.io/packages/helm/cert-manager/cert-manager
# helm upgrade --install cert-manager jetstack/cert-manager -n cert-manager --create-namespace --set installCRDs=true
resource "helm_release" "cert-manager" {
  depends_on = [helm_release.prometheus]

  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "~>1.7.1"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }

  set {
    name  = "prometheus.servicemonitor.enabled"
    value = true
  }
}

resource "helm_release" "cert-manager-resources" {
  depends_on = [helm_release.cert-manager]

  name             = "cert-manager-resources"
  chart            = "../charts/cert-manager-resources"
  namespace        = "cert-manager"

  set {
    name  = "certificates.staging.create"
    value = var.CreateStagingCertificate
  }

  set {
    name  = "certificates.staging.email"
    value = "${random_string.randomStaging.result}@kvhrr.com"
  }

  set {
    name  = "certificates.production.create"
    value = var.CreateProductionCertificate
  }

  set {
    name  = "certificates.production.email"
    value = "${random_string.randomProduction.result}@kvhrr.com"
  }

  set {
    name  = "certificates.dnsName"
    value = local.EnvDomainName
  }
}

resource "random_string" "randomStaging" {
  length = 16
  special = false
  lower = true
  upper = false
  min_lower = 5
  min_numeric = 0
}

resource "random_string" "randomProduction" {
  length = 16
  special = false
  lower = true
  upper = false
  min_lower = 5
  min_numeric = 0
}