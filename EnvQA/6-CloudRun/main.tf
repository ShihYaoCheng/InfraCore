# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "battle-london" {
  source = "../../Modules/CloudRun/0.1.0"

  ProjectName = var.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPRegion    = "europe-west2" 
  
  CloudRunName = "battle-europe-west2"
  CloudRunImage = "gcr.io/cqi-operation/sk-battle:v2.6.0C1"
}

module "battle-iowa" {
  source = "../../Modules/CloudRun/0.1.0"

  ProjectName = var.ProjectName
  GCPProjectID = var.GCPProjectID
  GCPRegion    = "us-central1"

  CloudRunName = "battle-us-central1"
  CloudRunImage = "gcr.io/cqi-operation/sk-battle:v2.6.0C1"
}
