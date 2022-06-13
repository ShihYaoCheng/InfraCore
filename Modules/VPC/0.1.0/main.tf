# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "VPC" {
  source  = "terraform-google-modules/network/google"
  version = "~>5.1.0"

  network_name = var.ProjectName
  project_id   = var.GCPProjectID

  auto_create_subnetworks = true
  #  subnets                 = []

  # https://www.calculator.net/ip-subnet-calculator.html
  subnets = [
    {
      subnet_name   = "london"
      subnet_ip     = "192.168.0.0/28"
      subnet_region = "europe-west2"
      subnet_private_access = true # Whether this subnet will have private Google access enabled
      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
    },
    {
      subnet_name   = "iowa"
      subnet_ip     = "192.168.0.16/28"
      subnet_region = "us-central1"
      subnet_private_access = true # Whether this subnet will have private Google access enabled
      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
    },
    {
      subnet_name   = "taiwan"
      subnet_ip     = "192.168.0.32/28"
      subnet_region = "asia-east1"
      subnet_private_access = true # Whether this subnet will have private Google access enabled
      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
    },
  ]

  # https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits
  # https://cidr.xyz/
  #  subnets = [
  #    {
  #      subnet_name   = local.VPCName
  #      #      subnet_ip     = "172.16.0.0/20"
  #      subnet_ip     = "10.0.0.0/16" # Count = 65536, Worker Node.
  #      subnet_region = var.GCPRegion
  #    },
  #  ]
  #
  #  secondary_ranges = {
  #    "${local.VPCName}" = [
  #      {
  #        range_name    = "pod-ip-range"
  #        ip_cidr_range = "10.10.0.0/16" # Count = 65536.
  #        #        ip_cidr_range = "172.16.16.0/20"
  #        #        ip_cidr_range = "192.168.100.0/24" # cause ip exhausted, don't do that.
  #      },
  #      {
  #        range_name    = "service-ip-range"
  #        #        ip_cidr_range = "172.16.32.0/20"
  #        ip_cidr_range = "10.20.0.0/16" # Count = 65536.
  #      },
  #    ]
  #  }
}
