resource "helm_release" "configuration" {
  name             = "configuration"
  chart            = "../charts/dz-configuration"
  namespace        = "default"
}