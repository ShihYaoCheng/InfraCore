# https://polaris.docs.fairwinds.com/
# https://github.com/FairwindsOps/polaris
# https://github.com/FairwindsOps/charts/tree/master/stable/polaris
# Best Practices for Kubernetes Workload Configuration.
resource "helm_release" "polaris" {
  name             = "polaris"
  repository       = "https://charts.fairwinds.com/stable"
  chart            = "polaris"
  version          = "~>5.1.0"
  create_namespace = true
  namespace        = "fairwinds"
}