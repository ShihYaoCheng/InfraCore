# https://github.com/terraform-google-modules/terraform-google-network/blob/v5.1.0/examples/submodule_vpc_serverless_connector/main.tf
#resource "google_project_service" "vpc-access-api" {
#  project = var.GCPProjectID
#  service = "vpcaccess.googleapis.com"
#}

# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest/submodules/vpc-serverless-connector-beta
# https://www.calculator.net/ip-subnet-calculator.html
module "serverless-connector" {
#  depends_on = [google_project_service.vpc-access-api]
  
  count = 0

  source         = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
  project_id     = var.GCPProjectID
  vpc_connectors = [
    {
      name            = "${var.ProjectName}-${var.GCPRegion}"
      subnet_name     = "${var.ProjectName}-${var.GCPRegion}"
      region          = var.GCPRegion
      host_project_id = var.GCPProjectID
      machine_type    = var.ConnectorMachineType
      min_instances   = 2
      max_instances   = 3
      max_throughput  = 300
    }
  ]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vpc_access_connector
# https://www.calculator.net/ip-subnet-calculator.html
#resource "google_vpc_access_connector" "connector" {
#  name          = "vpc-con"
#  ip_cidr_range = "10.10.10.0/28"
#  network       = var.ProjectName
#}


