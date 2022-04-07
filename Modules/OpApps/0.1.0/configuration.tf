resource "helm_release" "configuration" {
  name             = "configuration"
  chart            = "${path.module}/Charts/sk-configuration"
  namespace        = "default"
}