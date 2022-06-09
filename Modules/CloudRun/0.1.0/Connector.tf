# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest/submodules/vpc-serverless-connector-beta
# https://www.calculator.net/ip-subnet-calculator.html
#module "serverless-connector" {
#  source         = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
#  project_id     = var.GCPProjectID
#  vpc_connectors = [
#    {
#      name            = "central-serverless"
#      region          = var.GCPRegion
#      subnet_name     = "cqi-sk-sre"
#      host_project_id = var.GCPProjectID
#      #  Possible values are: [f1-micro, e2-micro, e2-standard-4]
#      machine_type    = "e2-micro"
#      min_instances   = 2
#      max_instances   = 3
#      max_throughput  = 300
#    }
#  ]
#}

# https://www.calculator.net/ip-subnet-calculator.html
resource "google_vpc_access_connector" "connector" {
  name          = "vpc-con"
  ip_cidr_range = "10.10.10.0/28"
  network       = var.ProjectName
}


