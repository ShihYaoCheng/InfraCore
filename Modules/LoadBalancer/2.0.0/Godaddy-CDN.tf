resource "helm_release" "GodaddyCDN" {
  name             = "godaddy-cdn-load-balancer"
  chart            = "${path.module}/Charts/Godaddy"
  namespace        = "default"

  set {
    name  = "domainName"
    value = var.GodaddyDomainName
  }

  set {
    name  = "subDomainNames"
    value = "cdn"
  }

  set {
    name  = "ip"
    value = google_compute_global_address.CDN.address
  }

  set_sensitive {
    name  = "godaddy.key"
    value = var.GodaddyAPIKey
  }

  set_sensitive {
    name  = "godaddy.secret"
    value = var.GodaddyAPISecret
  }
}
