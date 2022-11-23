# https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
module "vpc" {
  source  = "../../Modules/VPC/0.4.0"

  ProjectName = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
}

