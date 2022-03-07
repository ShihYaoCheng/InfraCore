#// https://goldilocks.docs.fairwinds.com/
#// Goldilocks is a utility that can help you identify a starting point for resource requests and limits.
#resource "helm_release" "goldilocks" {
#  count            = 0
#  name             = "goldilocks"
#  repository       = "https://charts.fairwinds.com/stable"
#  chart            = "goldilocks"
#  version          = "~>v3.3.0"
#  create_namespace = true
#  namespace        = "fairwinds"
#
#  set {
#    name  = "vpa.enabled"
#    value = "true"
#  }
#}
#
#// https://polaris.docs.fairwinds.com/
#// https://github.com/FairwindsOps/polaris
#// https://github.com/FairwindsOps/charts/tree/master/stable/polaris
#// Best Practices for Kubernetes Workload Configuration.
#resource "helm_release" "polaris" {
#  name             = "polaris"
#  repository       = "https://charts.fairwinds.com/stable"
#  chart            = "polaris"
#  version          = "~>4.2.0"
#  create_namespace = true
#  namespace        = "fairwinds"
#}
#
#// https://rbac-manager.docs.fairwinds.com/
#// https://github.com/FairwindsOps/rbac-manager
#// https://github.com/FairwindsOps/charts/tree/master/stable/rbac-manager
#// RBAC Manager is designed to simplify authorization in Kubernetes.
#resource "helm_release" "rbac-manager" {
#  name             = "rbac-manager"
#  repository       = "https://charts.fairwinds.com/stable"
#  chart            = "rbac-manager"
#  version          = "~>1.8.2"
#  create_namespace = true
#  namespace        = "fairwinds"
#}