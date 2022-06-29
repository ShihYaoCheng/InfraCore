# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "LoadBalancer" {
  source = "../../Modules/LoadBalancer/0.2.0"

  ProjectName  = file("../ProjectName.txt")
  LoadBalancerDomainName = "global.origingaia.com"
}



