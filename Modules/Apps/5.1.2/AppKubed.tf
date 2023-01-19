# https://artifacthub.io/packages/helm/appscode/kubed
resource "helm_release" "Kubed" {
  name             = "kubed"
  repository       = "https://charts.appscode.com/stable/"
  chart            = "kubed"
  version          = "~>0.13.2"
  namespace        = "kube-system"

  set {
    # Set cluster-name to something meaningful to you, say, prod, prod-us-east, qa, etc.
    # so that you can distinguish notifications sent by kubed.
    name  = "config.clusterName"
    value = var.ProjectName
  }

  set {
    # If set, configmaps and secrets from only this namespace will be synced
    name  = "config.configSourceNamespace"
    value = "cert-manager"
  }
}