
// https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~>5.0.0"

  project_id   = var.GCPProjectID
  network_name = local.VPCName

  auto_create_subnetworks = false

  # https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits
  # https://cidr.xyz/
  subnets = [
    {
      subnet_name   = local.VPCName
#      subnet_ip     = "172.16.0.0/20"
      subnet_ip     = "10.0.0.0/16" # Count = 65536, Worker Node.
      subnet_region = var.GCPRegion
    },
  ]

  secondary_ranges = {
    "${local.VPCName}" = [
      {
        range_name    = "pod-ip-range"
        ip_cidr_range = "10.10.0.0/16" # Count = 65536.
#        ip_cidr_range = "172.16.16.0/20"
#        ip_cidr_range = "192.168.100.0/24" # cause ip exhausted, don't do that.
      },
      {
        range_name    = "service-ip-range"
#        ip_cidr_range = "172.16.32.0/20"
        ip_cidr_range = "10.20.0.0/16" # Count = 65536.
      },
    ]
  }
}

