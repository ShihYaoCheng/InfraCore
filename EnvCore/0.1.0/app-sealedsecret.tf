# https://artifacthub.io/packages/helm/bitnami-labs/sealed-secrets
# https://github.com/bitnami-labs/sealed-secrets/tree/main/helm/sealed-secrets
# https://github.com/bitnami-labs/sealed-secrets/blob/main/helm/sealed-secrets/values.yaml
# https://github.com/bitnami-labs/sealed-secrets/blob/main/contrib/prometheus-mixin/dashboards/sealed-secrets-controller.json
resource "helm_release" "sealed-secret" {
  depends_on = [helm_release.prometheus]

  name       = "sealed-secret"
  chart      = "../charts/dz-sealedsecret"
  namespace = "kube-system"

  set_sensitive {
    name  = "keys.public"
    value = var.SealedSecretPublicKey
  }

  set_sensitive {
    name  = "keys.private"
    value = var.SealedSecretPrivateKey
  }
}
