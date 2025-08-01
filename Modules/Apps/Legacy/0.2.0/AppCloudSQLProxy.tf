﻿data "google_storage_bucket_object_content" "CloudSQLConnectionName" {
  count = var.CloudSQLProxy_Enable ? 1 : 0
  bucket = var.ProjectName
  name   = "CloudSQLConnectionName"
}

resource "kubernetes_namespace_v1" "CloudSQL" {
  count = var.CloudSQLProxy_Enable ? 1 : 0
  metadata {
    name = "cloud-sql"
  }
}

# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
module "CloudSQLWorkloadIdentity" {
  count = var.CloudSQLProxy_Enable ? 1 : 0
  depends_on = [kubernetes_namespace_v1.CloudSQL]

  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "21.0.0"

  project_id   = var.GCPProjectID
  cluster_name = var.ProjectName
  location     = var.GCPZone

  name         = "cloud-sql-proxy"
  gcp_sa_name = "${var.ProjectName}-cloud-sql-proxy"
  k8s_sa_name = "cloud-sql-proxy"

  namespace    = "cloud-sql"
  roles        = ["roles/cloudsql.client"]
}

resource "helm_release" "CloudSQLProxy" {
  count = var.CloudSQLProxy_Enable ? 1 : 0
  depends_on = [module.CloudSQLWorkloadIdentity]
  
  name             = "cloud-sql-proxy"
  chart            = "${path.module}/Charts/CloudSQL"
  namespace        = "cloud-sql"
  
  set {
    name  = "proxy.connectionName"
    value = data.google_storage_bucket_object_content.CloudSQLConnectionName[0].content
  }
}





