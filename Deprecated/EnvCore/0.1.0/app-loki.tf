# https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest
module "loki-service-account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "~>4.1.1"

  project_id = var.GCPProjectID
  names = ["${local.ProjectName}-loki"]

  generate_keys = true

  # https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles
  project_roles = ["${var.GCPProjectID}=>roles/storage.objectAdmin"]
}

resource "helm_release" "loki-resources-pre" {
  name             = "loki-resources-pre"
  chart            = "../charts/loki-resources-pre"
  namespace        = "loki"
  create_namespace = true

  set_sensitive {
    name  = "gcs_service_account_base64"
    value = base64encode(module.loki-service-account.key)
  }
}

resource "random_uuid" "loki-random-uuid" {}

# https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/latest/submodules/simple_bucket
module "loki-gcs-bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~>1.3"

  name       = "${local.ProjectName}-loki-${random_uuid.loki-random-uuid.result}"
  project_id = var.GCPProjectID

  # https://cloud.google.com/storage/docs/locations#available-locations
#  location   = "ASIA-EAST1"
  location   = var.GCPRegion

  # https://cloud.google.com/storage/docs/storage-classes#available_storage_classes
  storage_class = "NEARLINE"

  force_destroy = true
}

# https://artifacthub.io/packages/helm/grafana/loki-stack
# https://github.com/grafana/helm-charts/tree/main/charts/loki-stack
# https://github.com/grafana/helm-charts/blob/main/charts/loki-stack/values.yaml
# https://github.com/grafana/helm-charts/blob/main/charts/loki/values.yaml
resource "helm_release" "loki" {
  depends_on = [module.gke, helm_release.loki-resources-pre, helm_release.prometheus]

  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki-stack"
  version          = "~>2.6.1"
  namespace        = "loki"
  create_namespace = true

  values = [
    templatefile("${path.module}/values/loki.yaml",
    {
      bucket-name = module.loki-gcs-bucket.bucket.name
    })
  ]
}

