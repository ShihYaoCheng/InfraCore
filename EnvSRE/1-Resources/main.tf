module "sk-sre-bucket" {
  source  = "../../Modules/Resources/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCSBucketName = "sk-sre"
}