module "res" {
  source  = "../../Modules/Resources/0.3.0"

  ProjectName = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPRegion = var.GCPRegion
}