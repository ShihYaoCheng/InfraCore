module "res" {
  source  = "../../Modules/Resources/0.1.0"

  ProjectName = "cqi-sk-test"
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
}