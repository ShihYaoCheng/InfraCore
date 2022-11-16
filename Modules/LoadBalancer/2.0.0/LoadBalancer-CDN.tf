data "kubernetes_service" "OfficialWeb" {
  metadata {
    name      = "official-web"
    namespace = "official-web"
  }

  provider = kubernetes.tw
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGOfficialWeb" {
  name = jsondecode(data.kubernetes_service.OfficialWeb.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTW
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
resource "google_compute_backend_service" "OfficialWeb" {
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
  name            = "${var.ProjectName}-cdn"
  default_service = google_compute_backend_service.OfficialWeb.id

  host_rule {
    hosts        = local.cdnFQDNs
    path_matcher = "cdn"
  }

  path_matcher {
    name            = "cdn"
    default_service = google_compute_backend_service.OfficialWeb.id

    # https://cloud.google.com/cdn/docs/best-practices#versioned-urls
    path_rule {
      paths   = ["/official/*"]
#      paths   = formatlist("/official/%s/*", var.GodaddySubDomainNames)
#      paths   = ["/official/${var.GodaddySubDomainNames[0]}/*"]
      service = google_compute_backend_service.OfficialWeb.id
      route_action {
        url_rewrite {
          path_prefix_rewrite = "/"
        }
      }
    }
  }
}

#resource "random_id" "certificate" {
#  byte_length = 4
#  prefix      = "${var.ProjectName}-cdn-"
#  keepers = {
#    domains = local.v1
#  }
#}

resource "google_compute_managed_ssl_certificate" "CDN" {
  name             = "${var.ProjectName}-cdn"
#  name = random_id.certificate.hex
  managed {
#    domains = ["global.origingaia.com"]
    domains = ["cdn.${var.DomainName}"]
  }
}

resource "google_compute_target_https_proxy" "CDN" {
  name             = "${var.ProjectName}-cdn"
#  name             = random_id.certificate.hex
  url_map          = google_compute_url_map.CDN.id
  ssl_certificates = [google_compute_managed_ssl_certificate.CDN.id]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "CDN" {
  name         = "${var.ProjectName}-cdn"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "CDN" {
  name                  = "${var.ProjectName}-cdn"
#  name             = random_id.certificate.hex
  target                = google_compute_target_https_proxy.CDN.id
  port_range            = "443"
  ip_address            = google_compute_global_address.CDN.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
}