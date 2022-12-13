# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
data "kubernetes_service" "traefik" {
  metadata {
    name = "traefik"
    namespace = "traefik"
  }
}

output "TraefikLoadBalancerIP" {
  value = data.kubernetes_service.traefik.status
}