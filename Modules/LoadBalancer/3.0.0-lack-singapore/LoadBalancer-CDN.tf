data "kubernetes_service" "OfficialWeb" {
  metadata {
    name      = "official-web"
    namespace = "official-web"
  }

  provider = kubernetes.taiwan
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGOfficialWeb" {
  name = jsondecode(data.kubernetes_service.OfficialWeb.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTaiwan
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
resource "google_compute_backend_service" "OfficialWeb" {
  count = var.CDNEnabled ? 1 : 0
  
  name = "${var.ProjectName}-official-web"

  # (Optional) The protocol this BackendService uses to communicate with backends. 
  # The default is HTTP. NOTE: HTTP2 is only valid for beta HTTP/2 load balancer types and 
  # may result in errors if used with the GA API. 
  # Possible values are HTTP, HTTPS, HTTP2, TCP, SSL, and GRPC.
  protocol = "HTTP"

  # (Optional) How many seconds to wait for the backend before considering it a failed request. 
  # Default is 30 seconds. Valid range is [1, 86400].
  timeout_sec = 360

  # https://cloud.google.com/cdn/docs/best-practices
  enable_cdn = true
  cdn_policy {
    default_ttl = 3600 # 3600 = 1 hour.
    client_ttl = 3600 # 3600 = 1 hour.
    max_ttl = 10800 # 10800 = 3 hour.

    cache_mode = "CACHE_ALL_STATIC"
    signed_url_cache_max_age_sec = 3600

    cache_key_policy {
      include_host = false
      include_protocol = false
      include_query_string = false
    }

    negative_caching = true
  }

  backend {
    group          = data.google_compute_network_endpoint_group.NEGOfficialWeb.id
    balancing_mode = "RATE"

    # max_rate - (Optional) The max requests per second (RPS) of the group. 
    # Can be used with either RATE or UTILIZATION balancing modes, but required if RATE mode.
    # For RATE mode, either maxRate or one of maxRatePerInstance or maxRatePerEndpoint, 
    # as appropriate for group type, must be set.
    max_rate = 1000
  }

  health_checks = [google_compute_health_check.default.id]

  log_config {
    enable      = false
    sample_rate = 1
  }
}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
# https://cloud.google.com/load-balancing/docs/https/traffic-management-global#simple_host_and_path_rule
resource "google_compute_url_map" "CDN" {
  count = var.CDNEnabled ? 1 : 0
  
  name            = "${var.ProjectName}-cdn"
  default_service = google_compute_backend_service.OfficialWeb[0].id

  host_rule {
    hosts        = local.cdnFQDNs
#    hosts        = ["cdn.ponponsnake.com"]
    path_matcher = "cdn"
  }

  path_matcher {
    name            = "cdn"
    default_service = google_compute_backend_service.OfficialWeb[0].id

    # https://cloud.google.com/cdn/docs/best-practices#versioned-urls
    path_rule {
      paths   = ["${var.CDNUrlPathOfficial}/*"]
#      paths   = ["/official/*"]
#      paths   = formatlist("/official/%s/*", var.GodaddySubDomainNames)
#      paths   = ["/official/${var.GodaddySubDomainNames[0]}/*"]
      service = google_compute_backend_service.OfficialWeb[0].id
      route_action {
        url_rewrite {
          path_prefix_rewrite = "/"
        }
      }
    }
  }
}

resource "random_id" "cert" {
  byte_length = 2
}

resource "google_compute_managed_ssl_certificate" "CDN" {
  count = var.CDNEnabled ? 1 : 0
  
  name             = "${var.ProjectName}-cdn-${random_id.cert.hex}"
#  name = random_id.certificate.hex
  managed {
#    domains = ["cdn.origingaia.com"]
    domains = local.cdnFQDNs
  }
}

resource "google_compute_target_https_proxy" "CDN" {
  count = var.CDNEnabled ? 1 : 0
  
  name             = "${var.ProjectName}-cdn-${random_id.cert.hex}"
#  name             = random_id.certificate.hex
  url_map          = google_compute_url_map.CDN[0].id
  ssl_certificates = [google_compute_managed_ssl_certificate.CDN[0].id]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "CDN" {
  count = var.CDNEnabled ? 1 : 0
  
  name         = "${var.ProjectName}-cdn"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "CDN" {
  count = var.CDNEnabled ? 1 : 0
  
  name                  = "${var.ProjectName}-cdn-${random_id.cert.hex}"
  target                = google_compute_target_https_proxy.CDN[0].id
  port_range            = "443"
  ip_address            = google_compute_global_address.CDN[0].id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
}