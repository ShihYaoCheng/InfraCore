
data "google_storage_bucket_object_content" "VeleroServiceAccountKey" {
  bucket = var.ProjectName
  name   = "VeleroServiceAccountKey"
}

resource "helm_release" "VeleroResourcesPre" {
  count = var.Velero_Enable ? 1 : 0
  
  name             = "velero-resources-pre"
  chart            = "${path.module}/Charts/velero-resources-pre"
  namespace        = "velero"
  create_namespace = true

  set_sensitive {
    name  = "gcs_service_account_base64"
    value = base64encode(data.google_storage_bucket_object_content.VeleroServiceAccountKey.content)
  }
}

# https://artifacthub.io/packages/helm/vmware-tanzu/velero
# https://github.com/vmware-tanzu/helm-charts/tree/main/charts/velero
# https://github.com/vmware-tanzu/helm-charts/blob/main/charts/velero/values.yaml
# helm upgrade --install velero vmware-tanzu/velero -n velero -f velero-values.yaml --set-file credentials.secretContents.cloud=~/velero-sa.json --create-namespace
resource "helm_release" "Velero" {
  count = var.Velero_Enable ? 1 : 0
  
  depends_on = [helm_release.Prometheus, helm_release.VeleroResourcesPre]

  name             = "velero"
  repository       = "https://vmware-tanzu.github.io/helm-charts"
  chart            = "velero"
  version          = "~>2.30.0"
  namespace        = "velero"
  create_namespace = true

  values = [
    templatefile("${path.module}/Values/velero.yaml",
      {
        bucket-name = "${var.ProjectName}-velero",
        backupSchedule = var.Velero_BackupSchedule,
        backupScheduleTTL = var.Velero_BackupScheduleTTL
      })
  ]
}

