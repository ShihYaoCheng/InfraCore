# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "VPC" {
  source  = "terraform-google-modules/network/google"
  version = "~>6.0.0"

  project_id   = var.GCPProjectID
  
  network_name = var.ProjectName
  
  auto_create_subnetworks = true

  # https://www.calculator.net/ip-subnet-calculator.html
  # https://cloud.google.com/nat/docs/gke-example#terraform
  # https://cidr.xyz/
  subnets = []
#  subnets = [
#    {
#      # London
#      subnet_name   = "${var.ProjectName}-ew2"
#      subnet_ip     = "192.168.0.0/28"
#      subnet_region = "europe-west2"
#      subnet_private_access = true # Whether this subnet will have private Google access enabled
#      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
#    },
#    {
#      # Iowa
#      subnet_name   = "${var.ProjectName}-uc1"
#      subnet_ip     = "192.168.0.16/28"
#      subnet_region = "us-central1"
#      subnet_private_access = true # Whether this subnet will have private Google access enabled
#      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
#    },
#    {
#      # Taiwan
#      subnet_name   = "${var.ProjectName}-ae1"
#      subnet_ip     = "192.168.0.32/28"
#      subnet_region = "asia-east1"
#      subnet_private_access = true # Whether this subnet will have private Google access enabled
#      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
#    },
#    {
#      # Singapore
#      subnet_name   = "${var.ProjectName}-as1"
#      subnet_ip     = "192.168.0.48/28"
#      subnet_region = "asia-southeast1"
#      subnet_private_access = true # Whether this subnet will have private Google access enabled
#      subnet_flow_logs = false # Whether the subnet will record and send flow log data to logging
#    }
#  ]
}
