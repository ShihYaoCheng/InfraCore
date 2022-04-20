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

  # Branch or Tag.
  set {
    name  = "server.additionalApplications[0].source.targetRevision"
    value = var.ArgoCD_AppTableBranchOrTag
  }
  set {
    name  = "server.additionalApplications[1].source.targetRevision"
    value = var.ArgoCD_AppFileBranchOrTag
  }
  set {
    name  = "server.additionalApplications[2].source.targetRevision"
    value = var.ArgoCD_AppUserBranchOrTag
  }
  set {
    name  = "server.additionalApplications[3].source.targetRevision"
    value = var.ArgoCD_AppBattleBranchOrTag
  }

  # Helm Value File.
  # https://stackoverflow.com/questions/53846273/helm-passing-array-values-through-set
  set {
    name  = "server.additionalApplications[0].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
  set {
    name  = "server.additionalApplications[1].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
  set {
    name  = "server.additionalApplications[2].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
  set {
    name  = "server.additionalApplications[3].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }

  #============================#
  # Set repository credentials #
  #============================#
  # https://github.com/helm/helm/issues/1987
  set_sensitive {
    name  = "configs.repositories.sk-table.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-table.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

  set_sensitive {
    name  = "configs.repositories.sk-file.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-file.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

  set_sensitive {
    name  = "configs.repositories.sk-user.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-user.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

  set_sensitive {
    name  = "configs.repositories.sk-battle.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-battle.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

#  values = [
#    "${file("./${path.module}/values/argocd.yaml")}"
#  ]

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [
    templatefile("${path.module}/values/argocd.yaml", {
      enableSelfHeal = var.ArgoCD_EnableSelfHeal
    })
  ]
}
