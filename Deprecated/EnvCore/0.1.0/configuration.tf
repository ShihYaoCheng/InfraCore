resource "helm_release" "configuration" {
  name             = "configuration"
  chart            = "../charts/sk-configuration"
  namespace        = "default"
}