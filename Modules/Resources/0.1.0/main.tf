# https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
module "ProjectBucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~>1.3"

  project_id = var.GCPProjectID
  # https://cloud.google.com/storage/docs/locations#available-locations
  location   = var.GCPRegion

  name = var.ProjectName

  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
  storage_class = "NEARLINE"

  # When deleting a bucket, this boolean option will delete all contained objects.
  # If false, Terraform will fail to delete buckets which contain objects.
  force_destroy = true
}

# https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
module "LokiBucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~>1.3"

  project_id = var.GCPProjectID
  # https://cloud.google.com/storage/docs/locations#available-locations
  location   = var.GCPRegion

  name = "${var.ProjectName}-loki"

  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
  storage_class = "NEARLINE"

  # When deleting a bucket, this boolean option will delete all contained objects.
  # If false, Terraform will fail to delete buckets which contain objects.
  force_destroy = true
}

# https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest
module "LokiServiceAccount" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~>4.1.1"

  project_id = var.GCPProjectID
  names      = ["${var.ProjectName}-Loki"]

  generate_keys = true

  # https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles
  project_roles = ["${var.GCPProjectID}=>roles/storage.objectAdmin"]
}

resource "google_storage_bucket_object" "LokiKey" {
  bucket  = var.ProjectName
  name    = "LokiServiceAccountKey"
  content = module.LokiServiceAccount.key
}

# https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
module "VeleroBucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~>1.3"

  project_id = var.GCPProjectID
  # https://cloud.google.com/storage/docs/locations#available-locations
  location   = var.GCPRegion

  name = "${var.ProjectName}-velero"

  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
  storage_class = "NEARLINE"

  # When deleting a bucket, this boolean option will delete all contained objects.
  # If false, Terraform will fail to delete buckets which contain objects.
  force_destroy = true
}

# https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest
module "VeleroServiceAccount" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~>4.1.1"

  project_id = var.GCPProjectID
  names      = ["${var.ProjectName}-Velero"]

  generate_keys = true

  # https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles
  project_roles = [
    "${var.GCPProjectID}=>roles/storage.objectAdmin",
    "${var.GCPProjectID}=>roles/compute.storageAdmin"
  ]
}

resource "google_storage_bucket_object" "VeleroKey" {
  bucket  = var.ProjectName
  name    = "VeleroServiceAccountKey"
  content = module.VeleroServiceAccount.key
}


