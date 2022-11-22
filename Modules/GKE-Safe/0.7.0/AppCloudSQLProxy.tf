data "google_storage_bucket_object_content" "CloudSQLConnectionName" {
  bucket = var.ProjectName
  name   = "CloudSQLConnectionName"
}

resource "kubernetes_namespace_v1" "CloudSQL" {
  metadata {
    name = "cloud-sql"
  }
}

locals {
  # Service Account format = "^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$"
  GCP_SA_NAME = lower("${var.ProjectName}-${var.UniqueName}-sql")
  K8S_SA_NAME = "sql-proxy"
}

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
module "CloudSQLWorkloadIdentity" {
  depends_on = [kubernetes_namespace_v1.CloudSQL]

  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "24.0.0"

  project_id   = var.GCPProjectID
  cluster_name = var.ProjectName
  location     = var.GCPZone

  name         = "cloud-sql-proxy"
  gcp_sa_name = local.GCP_SA_NAME
  k8s_sa_name = local.K8S_SA_NAME

  namespace    = "cloud-sql"
  roles        = ["roles/cloudsql.client"]
}

resource "helm_release" "CloudSQLProxy" {
  depends_on = [module.CloudSQLWorkloadIdentity]
  
  name             = "cloud-sql-proxy"
  chart            = "${path.module}/Charts/CloudSQL"
  namespace        = "cloud-sql"
  
  set {
    name  = "proxy.connectionName"
    value = data.google_storage_bucket_object_content.CloudSQLConnectionName.content
  }
  
  set {
    name  = "proxy.serviceAccountName"
    value = local.K8S_SA_NAME
  }
}

