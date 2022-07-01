# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
resource "google_compute_firewall" "default" {
  name    = "${var.ProjectName}-allow-lb-health-check"
  network = var.ProjectName

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  # https://cloud.google.com/load-balancing/docs/https/troubleshooting-ext-https-lbs#load_balanced_traffic_does_not_have_the_source_address_of_the_original_client
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["gke-worker-node"]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "default" {
  name         = var.ProjectName
  address_type = "EXTERNAL"
}

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

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service
# https://www.terraform.io/language/meta-arguments/resource-provider
# permission: Kubernetes Engine Viewer.
data "kubernetes_service" "BattleTW" {
  metadata {
    name = "battle"
    namespace = "battle"
  }

  provider = kubernetes.tw
}

#data "google_storage_bucket_object_content" "NEGBattle-TW" {
#  bucket = var.ProjectName
#  name   = "NEGBattleName-${var.NEGZone-TW}"
#}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGBattle-TW" {
  name = jsondecode(data.kubernetes_service.BattleTW.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTW
}

#data "google_storage_bucket_object_content" "NEGBattle-EU" {
#  bucket = var.ProjectName
#  name   = "NEGBattleName-${var.NEGZone-EU}"
#}

data "kubernetes_service" "BattleEU" {
  metadata {
    name = "battle"
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
resource "google_compute_backend_service" "battle" {
  name = "${var.ProjectName}-battle"

  protocol = "HTTP"
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
    max_rate = 1000
  }

  health_checks = [google_compute_health_check.default.id]

  log_config {
    enable = true
    sample_rate = 1
  }
}

#data "google_storage_bucket_object_content" "NEGFile-TW" {
#  bucket = var.ProjectName
#  name   = "NEGFileName-${var.NEGZone-TW}"
#}

data "kubernetes_service" "FileTW" {
  metadata {
    name = "file"
    namespace = "file"
  }

  provider = kubernetes.tw
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGFile-TW" {
  name = jsondecode(data.kubernetes_service.FileTW.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTW
}

#data "google_storage_bucket_object_content" "NEGFile-EU" {
#  bucket = var.ProjectName
#  name   = "NEGFileName-${var.NEGZone-EU}"
#}

data "kubernetes_service" "FileEU" {
  metadata {
    name = "file"
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
resource "google_compute_backend_service" "file" {
  name = "${var.ProjectName}-file"

  protocol = "HTTP"
  
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
    max_rate = 1000
  }
  health_checks = [google_compute_health_check.default.id]
  
  log_config {
    enable = true
    sample_rate = 1
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map
resource "google_compute_url_map" "default" {
  name            = var.ProjectName
  default_service = google_compute_backend_service.battle.id
  
  host_rule {
    hosts        = [var.LoadBalancerDomainName]
    path_matcher = "global"
  }

  path_matcher {
    name = "global"
    default_service = google_compute_backend_service.battle.id

    path_rule {
      paths = ["/api/battle/*"]
      service = google_compute_backend_service.battle.id
    }

    path_rule {
      paths = ["/api/file/*"]
      service = google_compute_backend_service.file.id
    }
  }
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

