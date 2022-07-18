# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "vpc" {
  source  = "../../Modules/VPC/0.1.0"

  ProjectName = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
}

