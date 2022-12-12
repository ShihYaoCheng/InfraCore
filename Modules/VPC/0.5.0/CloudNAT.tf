# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
# https://cloud.google.com/compute/docs/regions-zones
resource "google_compute_router" "EuropeLondon" {
  name    = var.ProjectName
  network = module.VPC.network_name
  region = "europe-west2"
  bgp {
    asn = 64514
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "EuropeLondon" {
  name                               = var.ProjectName
  router                             = google_compute_router.EuropeLondon.name
  region                             = google_compute_router.EuropeLondon.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

#=============================================================================
# Asia Taiwan
#=============================================================================
resource "google_compute_router" "AsiaTaiwan" {
  name    = var.ProjectName
  network = module.VPC.network_name
  region = "asia-east1"
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "AsiaTaiwan" {
  name                               = var.ProjectName
  router                             = google_compute_router.AsiaTaiwan.name
  region                             = google_compute_router.AsiaTaiwan.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

#=============================================================================
# Asia Singapore
#=============================================================================
resource "google_compute_router" "AsiaSingapore" {
  name    = var.ProjectName
  network = module.VPC.network_name
  region = "asia-southeast1"
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "AsiaSingapore" {
  name                               = var.ProjectName
  router                             = google_compute_router.AsiaSingapore.name
  region                             = google_compute_router.AsiaSingapore.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

#=============================================================================
# America California
#=============================================================================
resource "google_compute_router" "AmericaCalifornia" {
  name    = var.ProjectName
  network = module.VPC.network_name
  region = "us-west2"
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "AmericaCalifornia" {
  name                               = var.ProjectName
  router                             = google_compute_router.AmericaCalifornia.name
  region                             = google_compute_router.AmericaCalifornia.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
