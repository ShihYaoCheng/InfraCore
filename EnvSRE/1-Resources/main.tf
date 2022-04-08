module "sk-sre-bucket" {
  source  = "../../Modules/Resources/0.1.0"

  ProjectName = "cqi-sk-sre"
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
}