# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
module "backstage-workload-identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "21.0.0"

  project_id   = var.GCPProjectID
  cluster_name = var.ProjectName
  location     = var.GCPZone
  
  name         = "backstage-cloud-sql-proxy"
  gcp_sa_name = "${var.ProjectName}-backstage-sql-proxy"
  k8s_sa_name = "cloud-sql-proxy"
  
  namespace    = "backstage"
  roles        = ["roles/cloudsql.client"]
}

module "user-workload-identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "21.0.0"

  project_id   = var.GCPProjectID
  cluster_name = var.ProjectName
  location     = var.GCPZone
  
  name         = "user-cloud-sql-proxy"
  gcp_sa_name = "${var.ProjectName}-user-sql-proxy"
  k8s_sa_name = "cloud-sql-proxy"
  
  namespace    = "user"
  roles        = ["roles/cloudsql.client"]
  
}

