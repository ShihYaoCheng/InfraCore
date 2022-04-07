# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
module "OpApps" {
  source  = "../../Modules/OpApps/0.1.0"

  AutoRegisterDomainName = true
  GodaddyAPIKey = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret
}



