data "kubernetes_service" "FileTaiwan" {
  metadata {
    name      = "file"
    namespace = "file"
  }

  provider = kubernetes.taiwan
}

data "kubernetes_service" "FileLondon" {
  metadata {
    name      = "file"
    namespace = "file"
  }

  provider = kubernetes.london
}

#data "kubernetes_service" "FileSingapore" {
#  metadata {
#    name      = "file"
#    namespace = "file"
#  }
#
#  provider = kubernetes.singapore
#}

data "kubernetes_service" "FileLosAngeles" {
  metadata {
    name      = "file"
    namespace = "file"
  }

  provider = kubernetes.la
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network_endpoint_group
data "google_compute_network_endpoint_group" "NEGFile-Taiwan" {
  name = jsondecode(data.kubernetes_service.FileTaiwan.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneTaiwan
}

data "google_compute_network_endpoint_group" "NEGFile-London" {
  name = jsondecode(data.kubernetes_service.FileLondon.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneLondon
}

#data "google_compute_network_endpoint_group" "NEGFile-Singapore" {
#  name = jsondecode(data.kubernetes_service.FileSingapore.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
#  zone = var.ZoneSingapore
#}

data "google_compute_network_endpoint_group" "NEGFile-LosAngeles" {
  name = jsondecode(data.kubernetes_service.FileLosAngeles.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
  zone = var.ZoneLosAngeles
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

  # https://cloud.google.com/cdn/docs/best-practices
  enable_cdn = true
  cdn_policy {
    #    default_ttl = 3600 # 3600 = 1 hour.
    #    client_ttl = 3600 # 3600 = 1 hour.
    #    max_ttl = 10800 # 10800 = 3 hour.

    #    cache_mode = "CACHE_ALL_STATIC"
    cache_mode = "USE_ORIGIN_HEADERS"
    signed_url_cache_max_age_sec = 3600

    cache_key_policy {
      include_host = false
      include_protocol = false
      include_query_string = false
    }

    negative_caching = true
  }

  backend {
    group          = data.google_compute_network_endpoint_group.NEGFile-Taiwan.id
    balancing_mode = "RATE"

    # max_rate - (Optional) The max requests per second (RPS) of the group. 
    # Can be used with either RATE or UTILIZATION balancing modes, but required if RATE mode.
    # For RATE mode, either maxRate or one of maxRatePerInstance or maxRatePerEndpoint, 
    # as appropriate for group type, must be set.
    max_rate = 1000
  }
  backend {
    group          = data.google_compute_network_endpoint_group.NEGFile-London.id
    balancing_mode = "RATE"
    max_rate       = 1000
  }
#  backend {
#    group          = data.google_compute_network_endpoint_group.NEGFile-Singapore.id
#    balancing_mode = "RATE"
#    max_rate       = 1000
#  }
  backend {
    group          = data.google_compute_network_endpoint_group.NEGFile-LosAngeles.id
    balancing_mode = "RATE"
    max_rate       = 1000
  }
  
  health_checks = [google_compute_health_check.default.id]

  log_config {
    enable      = false
    sample_rate = 1
  }
}

