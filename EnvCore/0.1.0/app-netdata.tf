
# https://github.com/netdata/helmchart/tree/master/charts/netdata
# https://github.com/netdata/helmchart/blob/master/charts/netdata/values.yaml
resource "helm_release" "netdata" {
  name             = "netdata"
  repository       = "https://netdata.github.io/helmchart/"
  chart            = "netdata"
  version          = "~>3.7.0"
  create_namespace = true
  namespace        = "netdata"

  values = [
      "${file("${path.module}/values/netdata.yaml")}"
      ]
}

