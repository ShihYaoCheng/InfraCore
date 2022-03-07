## https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
## https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml
## https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/grafana/dashboards/nginx.json
## helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -n nginx --create-namespace
#resource "helm_release" "nginx" {
#  count = 0
#
#  # ServiceMonitor
#  depends_on = [helm_release.prometheus]
#
#  name             = "nginx"
#  repository       = "https://kubernetes.github.io/ingress-nginx"
#  chart            = "ingress-nginx"
#  version          = "~>4.0.17"
#  namespace        = "nginx"
#  create_namespace = true
#
##  values = [
##    "${file("manifests/values-nginx.yaml")}"
##  ]
#
## https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
#  values = [
#    templatefile("${path.module}/values/nginx.yaml", {
#      env-domain-name = local.EnvDomainName
##      tls-certificate = var.UseProductionCertificate ? "cert-manager/cert.production" : "cert-manager/cert.staging"
#      tls-certificate = "cert-manager/cert.staging"
#    })
#  ]
#}
#
