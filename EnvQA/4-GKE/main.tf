# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "gke" {
  source  = "../../Modules/GKE/0.1.0"

  ProjectName = "cqi-sk-qa"
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  GKE-Zones = ["asia-east1-a"]

  GKE-AutoScaling-MinCPU = 1
  GKE-AutoScaling-MaxCPU = 5
  GKE-AutoScaling-MinMemoryGB = 5
  GKE-AutoScaling-MaxMemoryGB = 15
  GKE-NodeCount-e2-medium = 2
  GKE-NodeCount-e2-high-cpu-4 = 0
  GKE-NodeCount-e2-standard-2 = 1
}

