resource "helm_release" "Configuration" {
  name             = "configuration"
  chart            = "${path.module}/Charts/Configuration"
  namespace        = "default"
}
