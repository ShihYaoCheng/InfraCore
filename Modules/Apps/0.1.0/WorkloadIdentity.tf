# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
module "kubernetes-engine_workload-identity" {
  count   = 0
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version = "21.0.0"

  name         = "test100"
  project_id   = var.GCPProjectID
  #  gcp_sa_name = "test100"
  #  k8s_sa_name = "test100"
  namespace    = "default"
  roles        = ["roles/storage.admin"]
  cluster_name = var.ProjectName
  location     = var.GCPZone
}

