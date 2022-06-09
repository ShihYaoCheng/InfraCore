# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "Applications" {
  source = "../../Modules/CloudRun/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion    = var.GCPRegion
}



