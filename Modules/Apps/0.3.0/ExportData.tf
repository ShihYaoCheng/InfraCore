## https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service
## https://www.terraform.io/language/meta-arguments/resource-provider
#data "kubernetes_service" "battle" {
#  depends_on = [helm_release.Prometheus]
#  metadata {
#    name = "battle"
#    namespace = "battle"
#  }
#  
#  provider = ""
#}

# require permission: Storage Admin
#resource "google_storage_bucket_object" "NEG-Battle" {
#  depends_on = [helm_release.Prometheus]
#  bucket  = var.ProjectName
#  name    = "NEGBattleName-${var.GCPZone}"
#  content = jsondecode(data.kubernetes_service.battle.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
#}

#data "kubernetes_service" "file" {
#  depends_on = [helm_release.ArgoCDFull, helm_release.ArgoCDBattle]
#  metadata {
#    name = "file"
#    namespace = "file"
#  }
#}
#
## require permission: Storage Admin
#resource "google_storage_bucket_object" "NEG-File" {
#  depends_on = [helm_release.ArgoCDFull, helm_release.ArgoCDBattle]
#  bucket  = var.ProjectName
#  name    = "NEGFileName-${var.GCPZone}"
#  content = jsondecode(data.kubernetes_service.file.metadata[0].annotations["cloud.google.com/neg-status"])["network_endpoint_groups"]["80"]
#}
