resource "helm_release" "GodaddyCDN" {
  count = var.CDNEnabled ? 1 : 0
  
  name             = "godaddy-cdn-load-balancer"
  chart            = "${path.module}/Charts/Godaddy"
  namespace        = "default"

  set {
    name  = "domainName"
    value = var.DomainName
  }

  set {
    name  = "subDomainNames"
    value = local.cdnSubDomainsHelm
  }

  set {
    name  = "ip"
    value = google_compute_global_address.CDN[0].address
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
