# https://artifacthub.io/packages/helm/fairwinds-stable/goldilocks
# https://goldilocks.docs.fairwinds.com/
# Goldilocks is a utility that can help you identify a starting point for resource requests and limits.
# find resource requests and limits with VPA.
resource "helm_release" "Goldilocks" {
  count            = 0
  name             = "goldilocks"
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "goldilocks"
  version          = "~>6.1.4"
  create_namespace = true
  namespace        = "fairwinds"

  set {
    name  = "vpa.enabled"
    value = "true"
  }
}

# https://artifacthub.io/packages/helm/fairwinds-stable/polaris
# https://polaris.docs.fairwinds.com/
# https://github.com/FairwindsOps/polaris
# https://github.com/FairwindsOps/charts/tree/master/stable/polaris
# Best Practices for Kubernetes Workload Configuration.(check YAML files)
resource "helm_release" "Polaris" {
  count = 0
  name             = "polaris"
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "polaris"
  version          = "~>5.4.1"
  create_namespace = true
  namespace        = "fairwinds"
  
  set {
    name  = "dashboard.resources.requests.cpu"
    value = "1m"
  }
  
  set {
    name  = "webhook.resources.requests.cpu"
    value = "1m"
  }
}

# https://artifacthub.io/packages/helm/fairwinds-stable/rbac-manager
# https://rbac-manager.docs.fairwinds.com/
# https://github.com/FairwindsOps/rbac-manager
# https://github.com/FairwindsOps/charts/tree/master/stable/rbac-manager
# RBAC Manager is designed to simplify authorization in Kubernetes.
# helm upgrade --install rbac-manager fairwinds-stable/rbac-manager -n rbac-manager --create-namespace
# helm uninstall rbac-manager -n rbac-manager
resource "helm_release" "RBACManager" {
  name             = "rbac-manager"
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "rbac-manager"
  version          = "~>1.15.1"
  create_namespace = true
  namespace        = "fairwinds"
  
  set {
    name  = "resources.requests.cpu"
    value = "1m"
  }
}