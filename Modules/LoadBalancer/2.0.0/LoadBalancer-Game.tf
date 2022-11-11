# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service
# https://www.terraform.io/language/meta-arguments/resource-provider
# permission: Kubernetes Engine Viewer.
data "kubernetes_service" "BattleTW" {
  metadata {
    name      = "battle"
    namespace = "battle"
  }

  provider = kubernetes.tw
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGBattle-TW" {
  name = jsondecode(data.kubernetes_service.BattleTW.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTW
}

data "kubernetes_service" "BattleEU" {
  metadata {
    name      = "battle"
    namespace = "battle"
  }

  provider = kubernetes.eu
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGBattle-EU" {
  name = jsondecode(data.kubernetes_service.BattleEU.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneEU
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
resource "google_compute_backend_service" "Battle" {
  name = "${var.ProjectName}-battle"

  # (Optional) The protocol this BackendService uses to communicate with backends. 
  # The default is HTTP. NOTE: HTTP2 is only valid for beta HTTP/2 load balancer types and 
  # may result in errors if used with the GA API. 
  # Possible values are HTTP, HTTPS, HTTP2, TCP, SSL, and GRPC.
  protocol = "HTTP"

  # (Optional) How many seconds to wait for the backend before considering it a failed request. 
  # Default is 30 seconds. Valid range is [1, 86400].
  timeout_sec = 360
  
  backend {
    group          = data.google_compute_network_endpoint_group.NEGBattle-TW.id
    balancing_mode = "RATE"

    # max_rate - (Optional) The max requests per second (RPS) of the group. 
    # Can be used with either RATE or UTILIZATION balancing modes, but required if RATE mode.
    # For RATE mode, either maxRate or one of maxRatePerInstance or maxRatePerEndpoint, 
    # as appropriate for group type, must be set.
    max_rate = 1000
  }
  backend {
    group          = data.google_compute_network_endpoint_group.NEGBattle-EU.id
    balancing_mode = "RATE"
    max_rate       = 1000
  }

  health_checks = [google_compute_health_check.default.id]

  log_config {
    enable      = false
    sample_rate = 1
  }
}

data "kubernetes_service" "FileTW" {
  metadata {
    name      = "file"
    namespace = "file"
  }

  provider = kubernetes.tw
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGFile-TW" {
  name = jsondecode(data.kubernetes_service.FileTW.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTW
}

data "kubernetes_service" "FileEU" {
  metadata {
    name      = "file"
    namespace = "file"
  }

  provider = kubernetes.eu
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGFile-EU" {
  name = jsondecode(data.kubernetes_service.FileEU.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneEU
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
resource "google_compute_backend_service" "File" {
  name = "${var.ProjectName}-file"

  # (Optional) The protocol this BackendService uses to communicate with backends. 
  # The default is HTTP. NOTE: HTTP2 is only valid for beta HTTP/2 load balancer types and 
  # may result in errors if used with the GA API. 
  # Possible values are HTTP, HTTPS, HTTP2, TCP, SSL, and GRPC.
  protocol = "HTTP"

  # (Optional) How many seconds to wait for the backend before considering it a failed request. 
  # Default is 30 seconds. Valid range is [1, 86400].
  timeout_sec = 360

  backend {
    group          = data.google_compute_network_endpoint_group.NEGFile-TW.id
    balancing_mode = "RATE"

    # max_rate - (Optional) The max requests per second (RPS) of the group. 
    # Can be used with either RATE or UTILIZATION balancing modes, but required if RATE mode.
    # For RATE mode, either maxRate or one of maxRatePerInstance or maxRatePerEndpoint, 
    # as appropriate for group type, must be set.
    max_rate = 1000
  }

  backend {
    group          = data.google_compute_network_endpoint_group.NEGFile-EU.id
    balancing_mode = "RATE"
    max_rate       = 1000
  }
  health_checks = [google_compute_health_check.default.id]

  log_config {
    enable      = false
    sample_rate = 1
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# https://cloud.google.com/load-balancing/docs/https/traffic-management-global#simple_host_and_path_rule
resource "google_compute_url_map" "Game" {
  name            = var.ProjectName
  default_service = google_compute_backend_service.Battle.id

  host_rule {
    hosts        = local.GodaddyFQDNs
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

