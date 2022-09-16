resource "helm_release" "Godaddy" {
  name             = "godaddy-load-balancer"
  chart            = "${path.module}/Charts/Godaddy"
  namespace        = "default"

  set {
    name  = "domainName"
    value = var.GodaddyDomainName
  }

  set {
    name  = "subDomainName"
    value = var.GodaddySubDomainName
  }

  set {
    name  = "ip"
    value = google_compute_global_address.default.address
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
