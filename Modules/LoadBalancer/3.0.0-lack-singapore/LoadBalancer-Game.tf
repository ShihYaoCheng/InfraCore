# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# https://cloud.google.com/load-balancing/docs/https/traffic-management-global#simple_host_and_path_rule
resource "google_compute_url_map" "Game" {
  name            = var.ProjectName
  default_service = google_compute_backend_service.Battle.id

  host_rule {
    hosts        = local.gameFQDNs
    path_matcher = "game"
  }

  path_matcher {
    name            = "game"
    default_service = google_compute_backend_service.File.id

    path_rule {
      paths   = ["/api/battle/*"]
      service = google_compute_backend_service.Battle.id
    }

    path_rule {
      paths   = ["/api/file/*"]
      service = google_compute_backend_service.File.id
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
resource "google_compute_target_http_proxy" "Game" {
  name    = var.ProjectName
  url_map = google_compute_url_map.Game.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "Game" {
  name         = var.ProjectName
  address_type = "EXTERNAL"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
resource "google_compute_global_forwarding_rule" "Game" {
  name                  = var.ProjectName
  target                = google_compute_target_http_proxy.Game.id
  port_range            = "80"
  ip_address            = google_compute_global_address.Game.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
}

