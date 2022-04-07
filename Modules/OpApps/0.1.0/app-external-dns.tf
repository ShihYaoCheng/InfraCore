// https://artifacthub.io/packages/helm/bitnami/external-dns
// It doesn't support godaddy.

resource "helm_release" "external-dns" {
  count = var.AutoRegisterDomainName ? 1 : 0

  name      = "external-dns"
  chart     = "${path.module}/Charts/external-dns"
  namespace = "default" // only work in default namespace.

  set {
    name  = "godaddy.api.key"
    value = var.GodaddyAPIKey
  }

  set {
    name  = "godaddy.api.secret"
    value = var.GodaddyAPISecret
  }
}
