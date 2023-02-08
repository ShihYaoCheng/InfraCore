//resource "helm_release" "linkerd" {
//  name             = "linkerd"
//  repository       = "https://helm.linkerd.io/stable"
//  chart            = "linkerd2"
//  version          = "2.10.2"
//
//  set {
//    name = "identityTrustAnchorsPEM"
////    value = file("./private-linkerd/ca.crt")
//    value = base64decode(var.linkerd-root-ca-certificate-base64)
//  }
//
//  set {
//    name = "identity.issuer.tls.crtPEM"
////    value = file("./private-linkerd/issuer.crt")
//    value = base64decode(var.linkerd-issuer-ca-certificate-base64)
//  }
//
//  set_sensitive {
//    name = "identity.issuer.tls.keyPEM"
////    value = file("./private-linkerd/issuer.key")
//    value = base64decode(var.linkerd-issuer-ca-private-key-base64)
//  }
//
//  set {
//    name = "identity.issuer.crtExpiry"
//    value = timeadd(timestamp(), var.linkerd-issuer-ca-certificate-expiry)
//  }
//}
//
//resource "helm_release" "linkerd-viz" {
//  depends_on = [helm_release.linkerd]
//
//  name             = "linkerd-viz"
//  repository       = "https://helm.linkerd.io/stable"
//  chart            = "linkerd-viz"
//  version          = "2.10.2"
//}
//
//resource "helm_release" "linkerd-jaeger" {
//  depends_on = [helm_release.linkerd]
//
//  name             = "linkerd-jaeger"
//  repository       = "https://helm.linkerd.io/stable"
//  chart            = "linkerd-jaeger"
//  version          = "2.10.2"
//}