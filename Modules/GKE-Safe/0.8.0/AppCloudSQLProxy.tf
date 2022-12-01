locals {
  CloudSQLNamespace = "cloud-sql"
  # Service Account format = "^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$"
  GCP_SA_NAME = lower("${var.ProjectName}-${var.UniqueName}-sql")
  K8S_SA_NAME = "sql-proxy"
  
  CloudSQLReleaseName = "cloud-sql-proxy"
}

#data "google_storage_bucket_object_content" "CloudSQLConnectionName" {
#  bucket = var.ProjectName
#  name   = "CloudSQLConnectionName"
#}

data "google_storage_bucket_object_content" "CloudSQLInstanceName" {
  bucket = var.ProjectName
  name   = "CloudSQLInstanceName"
}

resource "kubernetes_namespace_v1" "CloudSQL" {
  metadata {
#    name = "cloud-sql"
    name = local.CloudSQLNamespace
  }
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

#  namespace    = "cloud-sql"
  namespace    = local.CloudSQLNamespace
  roles        = ["roles/cloudsql.client"]
}

# https://artifacthub.io/packages/helm/rimusz/gcloud-sqlproxy
# https://github.com/rimusz/charts/blob/master/stable/gcloud-sqlproxy/values.yaml
# https://github.com/rimusz/charts/tree/master/stable/gcloud-sqlproxy/
resource "helm_release" "CloudSQLProxy" {
  name             = local.CloudSQLReleaseName
  repository       = "https://charts.rimusz.net"
  chart            = "gcloud-sqlproxy"
  version          = "~>0.23.0"
  namespace        = local.CloudSQLNamespace
  
  set {
    name  = "cloudsql.instances[0].instance"
    value = data.google_storage_bucket_object_content.CloudSQLInstanceName.content
  }

  set {
    name  = "cloudsql.instances[0].project"
    value = var.GCPProjectID
  }

  set {
    name  = "cloudsql.instances[0].region"
    value = var.GCPRegion
  }

  set {
    name  = "cloudsql.instances[0].port"
    value = "3306"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = local.K8S_SA_NAME
  }
  
  set {
    name  = "nameOverride"
    value = local.CloudSQLReleaseName
  }

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [templatefile("${path.module}/Values/CloudSQLProxy.yaml", {})]
}

#resource "helm_release" "CloudSQLProxy" {
#  depends_on = [module.CloudSQLWorkloadIdentity]
#
#  name             = "cloud-sql-proxy"
#  chart            = "${path.module}/Charts/CloudSQL"
#  namespace        = "cloud-sql"
#
#  set {
#    name  = "proxy.connectionName"
#    value = data.google_storage_bucket_object_content.CloudSQLConnectionName.content
#  }
#
#  set {
#    name  = "proxy.serviceAccountName"
#    value = local.K8S_SA_NAME
#  }
#}

