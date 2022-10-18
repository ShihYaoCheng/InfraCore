module "Resource" {
  source  = "../../Modules/Resources/0.2.0"

  ProjectName = local.ProjectName
  
  GCPProjectID = local.ProjectID
  GCPRegion = var.GCPRegion
}