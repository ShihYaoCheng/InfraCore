# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "vpc" {
  source  = "../../Modules/VPC/0.1.0"

  ProjectName = "cqi-sk-prod"
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
}

