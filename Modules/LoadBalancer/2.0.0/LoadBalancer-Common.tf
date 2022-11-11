# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# Add a firewall rule to the VPC network that allows health checks to work correctly.
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

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check
resource "google_compute_health_check" "default" {
  name = var.ProjectName
  http_health_check {
    #port_name          = "health-check-port"

    # USE_SERVING_PORT: 
    # For NetworkEndpointGroup, the port specified for each network endpoint is used for 
    # health checking. For other backends, the port or named port specified in the 
    # Backend Service is used for health checking.
    #
    # If not specified, HTTP health check follows behavior specified in port and portName 
    # fields. Possible values are USE_FIXED_PORT, USE_NAMED_PORT, and USE_SERVING_PORT.
    port_specification = "USE_SERVING_PORT"
    #port_specification = "USE_FIXED_PORT"
    request_path       = "/health/live"
    #request_path       = "/"
  }
}