# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
resource "google_compute_firewall" "default" {
  name    = "${var.ProjectName}-allow-lb-health-check"
  network = var.ProjectName

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["gke-worker-node"]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "default" {
  name         = var.ProjectName
  address_type = "EXTERNAL"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_http_health_check
# Legacy.
#resource "google_compute_http_health_check" "default" {
#  name         = var.ProjectName
#  request_path = "/health/live"
#  port = 8080
#}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check
resource "google_compute_health_check" "default" {
  name = var.ProjectName
  http_health_check {
    #port_name          = "health-check-port"

    # USE_SERVING_PORT: 
    # For NetworkEndpointGroup, the port specified for each network endpoint is used for 
    # health checking. 
    # For other backends, the port or named port specified in the Backend Service is used for
    # health checking. 
    # If not specified, HTTP health check follows behavior specified in port and portName 
    # fields. Possible values are USE_FIXED_PORT, USE_NAMED_PORT, and USE_SERVING_PORT.
    port_specification = "USE_SERVING_PORT"
    #port_specification = "USE_FIXED_PORT"
    request_path       = "/health/live"
    #request_path       = "/"
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEG-TW-Battle" {
  name = "k8s-battle-battle-8080"
  zone = "asia-east1-a"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEG-EU-Battle" {
  name = "k8s-battle-battle-8080"
  zone = "europe-west2-a"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
#data "google_compute_network_endpoint_group" "NEG-US-Battle" {
#  name = "k8s-battle-battle-8080"
#  zone = "us-central1-a"
#}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service
resource "google_compute_backend_service" "default" {
  name = var.ProjectName

  protocol = "HTTP"
  backend {
    group          = data.google_compute_network_endpoint_group.NEG-TW-Battle.id
    balancing_mode = "RATE"

    # max_rate - (Optional) The max requests per second (RPS) of the group. 
    # Can be used with either RATE or UTILIZATION balancing modes, but required if RATE mode.
    # For RATE mode, either maxRate or one of maxRatePerInstance or maxRatePerEndpoint, 
    # as appropriate for group type, must be set.
    max_rate = 1000
  }
  backend {
    group          = data.google_compute_network_endpoint_group.NEG-EU-Battle.id
    balancing_mode = "RATE"

    # max_rate - (Optional) The max requests per second (RPS) of the group. 
    # Can be used with either RATE or UTILIZATION balancing modes, but required if RATE mode.
    # For RATE mode, either maxRate or one of maxRatePerInstance or maxRatePerEndpoint, 
    # as appropriate for group type, must be set.
    max_rate = 1000
  }
  health_checks = [google_compute_health_check.default.id]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
resource "google_compute_url_map" "default" {
  name            = var.ProjectName
  default_service = google_compute_backend_service.default.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy
resource "google_compute_target_http_proxy" "default" {
  name    = var.ProjectName
  url_map = google_compute_url_map.default.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.ProjectName
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"
  ip_address            = google_compute_global_address.default.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
}

