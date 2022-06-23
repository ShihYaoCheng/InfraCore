# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/0.1.0"

  ProjectName  = file("../ProjectName.txt")
}



