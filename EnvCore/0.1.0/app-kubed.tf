# https://artifacthub.io/packages/helm/appscode/kubed
resource "helm_release" "kubed" {
  name             = "kubed"
  repository       = "https://charts.appscode.com/stable/"
  chart            = "kubed"
  version          = "~>0.12.0"
  namespace        = "kube-system"

  set {
    name  = "config.clusterName"
    value = local.GKEName
  }

  set {
    name  = "config.configSourceNamespace"
    value = "cert-manager"
  }
}