# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
resource "google_compute_router" "router-ew2" {
  name    = var.ProjectName
  network = module.VPC.network_name
  region = "europe-west2"
  bgp {
    asn = 64514
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "nat-ew2" {
  name                               = var.ProjectName
  router                             = google_compute_router.router-ew2.name
  region                             = google_compute_router.router-ew2.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router" "router-ae1" {
  name    = var.ProjectName
  network = module.VPC.network_name
  region = "asia-east1"
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat-ae1" {
  name                               = var.ProjectName
  router                             = google_compute_router.router-ae1.name
  region                             = google_compute_router.router-ae1.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}





