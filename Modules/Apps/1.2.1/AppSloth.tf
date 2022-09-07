# https://artifacthub.io/packages/helm/appscode/kubed
#resource "helm_release" "Sloth" {
#  depends_on = [helm_release.Robusta]
#  name             = "sloth"
#  repository       = "https://slok.github.io/sloth"
#  chart            = "sloth"
#  version          = "~>0.5.2"
#  namespace        = "robusta"
#  create_namespace = true
#}
