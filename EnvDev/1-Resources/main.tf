module "sk-dev-bucket" {
  source  = "../../Modules/Resources/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCSBucketName = "sk-dev"
}