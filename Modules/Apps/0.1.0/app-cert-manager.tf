# https://artifacthub.io/packages/helm/cert-manager/cert-manager
# helm upgrade --install cert-manager jetstack/cert-manager -n cert-manager --create-namespace --set installCRDs=true
resource "helm_release" "CertManager" {
  depends_on = [helm_release.Prometheus]

  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "~>1.8.0"
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

resource "helm_release" "CertManagerResources" {
  depends_on = [helm_release.CertManager]

  name             = "cert-manager-resources"
  chart            = "${path.module}/Charts/cert-manager-resources"
  namespace        = "cert-manager"

  set {
    name  = "certificates.staging.create"
    value = var.CreateStagingCertificate
  }

  set {
    name  = "certificates.staging.email"
    value = "${random_string.RandomStaging.result}@kvhrr.com"
  }

  set {
    name  = "certificates.production.create"
    value = var.CreateProductionCertificate
  }

  set {
    name  = "certificates.production.email"
    value = "${random_string.RandomProduction.result}@kvhrr.com"
  }

  set {
    name  = "certificates.dnsName"
    value = var.DomainName
  }
}

resource "random_string" "RandomStaging" {
  length = 16
  special = false
  lower = true
  upper = false
  min_lower = 5
  min_numeric = 0
}

resource "random_string" "RandomProduction" {
  length = 16
  special = false
  lower = true
  upper = false
  min_lower = 5
  min_numeric = 0
}