resource "helm_release" "Configuration" {
  name             = "configuration"
  chart            = "${path.module}/Charts/sk-configuration"
  namespace        = "default"
}
