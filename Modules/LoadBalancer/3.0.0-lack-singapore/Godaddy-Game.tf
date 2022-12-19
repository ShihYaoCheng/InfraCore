resource "helm_release" "GodaddyGame" {
  name             = "godaddy-game-load-balancer"
  chart            = "${path.module}/Charts/Godaddy"
  namespace        = "default"

  set {
    name  = "domainName"
    value = var.DomainName
  }

  set {
    name  = "subDomainNames"
    value = local.gameSubDomainsHelm
  }

  set {
    name  = "ip"
    value = google_compute_global_address.Game.address
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
