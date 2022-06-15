# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "battle-tw" {
  source = "../../Modules/CloudRun/0.1.0"

  ProjectName = var.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPRegion    = var.GCPRegion
  
  CloudRunName = "battle-${var.GCPRegion}"
  CloudRunImage = "gcr.io/stellar-38931/sk-battle:sre-af369976"
}

#module "battle-n" {
#  source = "../../Modules/CloudRun/0.1.0"
#
#  GCPProjectID = var.GCPProjectID
#  GCPRegion    = "asia-northeast1"
#
#  Name = "battle-north"
#  Image = "gcr.io/stellar-38931/sk-battle:sre-5878b06e"
#}

