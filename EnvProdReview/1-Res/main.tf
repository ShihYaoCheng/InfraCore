module "res" {
  source  = "../../Modules/Resources/0.1.0"

  ProjectName = file("../ProjectName.txt")
  GCPProjectID = local.ProjectID
  GCPRegion = var.GCPRegion
}