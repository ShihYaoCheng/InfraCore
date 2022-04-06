# https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
module "sk-bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~>1.3"

  project_id = var.GCPProjectID
  # https://cloud.google.com/storage/docs/locations#available-locations
  location   = var.GCPRegion

  name = var.GCSBucketName

  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
  storage_class = "NEARLINE"

  # When deleting a bucket, this boolean option will delete all contained objects.
  # If false, Terraform will fail to delete buckets which contain objects.
  force_destroy = true
}

