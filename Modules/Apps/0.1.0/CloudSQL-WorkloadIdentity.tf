# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
module "backstage-workload-identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "21.0.0"

  name         = "cloud-sql-proxy"
  project_id   = var.GCPProjectID
  namespace    = "backstage"
  roles        = ["roles/cloudsql.client"]
  cluster_name = var.ProjectName
  location     = var.GCPZone
}

