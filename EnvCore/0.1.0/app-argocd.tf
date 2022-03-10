# https://artifacthub.io/packages/helm/argo/argo-cd
# https://github.com/argoproj/argo-helm/blob/master/charts/argo-cd/values.yaml
# https://github.com/argoproj/argo-helm/blob/argo-cd-3.35.2/charts/argo-cd/values.yaml

# helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
# helm upgrade --install argocd argo/argo-cd -f ./EnvCore/0.1.0/values/argocd.yaml -n argocd --create-namespace
# helm uninstall argocd -n argocd
resource "helm_release" "argocd" {
  depends_on = [helm_release.prometheus]

  count = var.ArgoCD_Enable ? 1 : 0

  name             = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "~>3.35.2"

  create_namespace = true
  namespace        = "argocd"

#  set {
#    name  = "server.additionalApplications[0].source.targetRevision"
#    value = var.ArgoCD_AppTableBranchOrTag
#  }
#  set {
#    name  = "server.additionalApplications[1].source.targetRevision"
#    value = var.ArgoCD_AppUserBranchOrTag
#  }

  # https://stackoverflow.com/questions/53846273/helm-passing-array-values-through-set
  set {
    name  = "server.additionalApplications[0].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
#  set {
#    name  = "server.additionalApplications[1].source.helm.valueFiles"
#    value = var.ArgoCD_RepositoryHelmPathValueFiles
#  }

  # https://github.com/helm/helm/issues/1987
  # Table Server.
#  set {
#    name  = "server.additionalApplications[0].source.helm.parameters[0].name"
#    value = "deployment.keys.public"
#  }
#  set {
#    name  = "server.additionalApplications[0].source.helm.parameters[0].value"
#    value = var.ArgoCD_ApplicationPublicKey
#  }
#  set {
#    name  = "server.additionalApplications[0].source.helm.parameters[1].name"
#    value = "deployment.keys.private"
#  }
#  set_sensitive {
#    name  = "server.additionalApplications[0].source.helm.parameters[1].value"
#    value = var.ArgoCD_ApplicationPrivateKey
#  }

  # User Server.
#  set {
#    name  = "server.additionalApplications[1].source.helm.parameters[0].name"
#    value = "deployment.publicKey"
#  }
#  set {
#    name  = "server.additionalApplications[1].source.helm.parameters[0].value"
#    value = var.ArgoCD_ApplicationPublicKey
#  }

  set_sensitive {
    name  = "configs.repositories.sk-helm-repo.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-helm-repo.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

#  set_sensitive {
#    name  = "configs.repositories.user.username"
#    value = var.ArgoCD_GitLabTokenName
#  }
#  set_sensitive {
#    name  = "configs.repositories.user.password"
#    value = var.ArgoCD_GitLabTokenSecret
#  }

  values = [
    "${file("./${path.module}/values/argocd.yaml")}"
  ]

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
#  values = [
#    templatefile("${path.module}/manifests/values-argocd-token.yaml", {
#      GitlabDeployTokenUserName = var.GitLabDeployTokenUserName
#      GitlabDeployTokenSecret = var.GitLabDeployTokenSecret
#    })
#  ]
}
