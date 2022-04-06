module "sk-sre-bucket" {
  source  = "../../Modules/1-GCPResources/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCSBucketName = "sk-sre"
}