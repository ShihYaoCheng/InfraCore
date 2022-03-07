#
## https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest
#module "velero-service-account" {
#  source  = "terraform-google-modules/service-accounts/google"
#  version = "~>4.1.1"
#
#  project_id = var.GCPProjectID
#  names = ["${local.ProjectName}-velero"]
#
#  generate_keys = true
#
#  # https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles
#  project_roles = [
#    "${var.GCPProjectID}=>roles/storage.objectAdmin",
#    "${var.GCPProjectID}=>roles/compute.storageAdmin"
#  ]
#}
#
#resource "helm_release" "velero-resources-pre" {
#  name             = "velero-resources-pre"
#  chart            = "../charts/velero-resources-pre"
#  namespace        = "velero"
#  create_namespace = true
#
#  set_sensitive {
#    name  = "gcs_service_account_base64"
#    value = base64encode(module.velero-service-account.key)
#  }
#}
#
#resource "random_uuid" "velero-random-uuid" {}
#
## https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
#module "velero-gcs-bucket" {
#  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
#  version = "~> 1.3"
#
#  name       = "${local.ProjectName}-velero-${random_uuid.velero-random-uuid.result}"
#  project_id = var.GCPProjectID
#
#  # https://cloud.google.com/storage/docs/locations#available-locations
#  location   = var.GCPRegion
#
#  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
#  storage_class = "NEARLINE"
#
#  force_destroy = true
#}
#
## https://github.com/vmware-tanzu/helm-charts/tree/main/charts/velero
## https://github.com/vmware-tanzu/helm-charts/blob/main/charts/velero/values.yaml
## helm upgrade --install velero vmware-tanzu/velero -n velero -f velero-values.yaml --set-file credentials.secretContents.cloud=~/velero-sa.json --create-namespace
#resource "helm_release" "velero" {
#  depends_on = [module.gke, helm_release.prometheus]
#
#  name             = "velero"
#  repository       = "https://vmware-tanzu.github.io/helm-charts"
#  chart            = "velero"
#  version          = "~>2.28.0"
#  namespace        = "velero"
#  create_namespace = true
#
#  values = [
#    templatefile("${path.module}/values/velero.yaml",
#      {
#        bucket-name = module.velero-gcs-bucket.bucket.name,
#      })
#  ]
#}
#
