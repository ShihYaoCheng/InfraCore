# https://artifacthub.io/packages/helm/argo/argo-cd
# https://github.com/argoproj/argo-helm/blob/master/charts/argo-cd/values.yaml
# https://github.com/argoproj/argo-helm/blob/argo-cd-3.35.2/charts/argo-cd/values.yaml
# helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
# helm uninstall argocd -n argocd

resource "helm_release" "ArgoCD" {
  depends_on = [helm_release.Prometheus]

  count = var.ArgoCD_Enable ? 1 : 0

  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "~>3.35.2"

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
    value = var.ArgoCD_AppBackstageBranchOrTag
  }
  set {
    name  = "server.additionalApplications[4].source.targetRevision"
    value = var.ArgoCD_AppBattleBranchOrTag
  }
  set {
    name  = "server.additionalApplications[5].source.targetRevision"
    value = var.ArgoCD_AppNFTBranchOrTag
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
  
  # [2] = User service.
  set {
    name  = "server.additionalApplications[2].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
  # [3] = Backstage service.
  set {
    name  = "server.additionalApplications[3].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
  # [4]
  set {
    name  = "server.additionalApplications[4].source.helm.valueFiles"
    value = var.ArgoCD_RepositoryHelmPathValueFiles
  }
  # [5]
  set {
    name  = "server.additionalApplications[5].source.helm.valueFiles"
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
    name  = "configs.repositories.sk-backstage.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-backstage.password"
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

  set_sensitive {
    name  = "configs.repositories.sk-nft.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-nft.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

  # https://stackoverflow.com/questions/64696721/how-do-i-pass-variables-to-a-yaml-file-in-heml-tf
  values = [
    templatefile("${path.module}/Values/argocd.yaml", {}),
    templatefile("${path.module}/Values/argocd-configs.yaml", {}),
    templatefile("${path.module}/Values/argocd-controller.yaml", {}),
    templatefile("${path.module}/Values/argocd-server.yaml", 
      {
        enableSelfHeal = var.ArgoCD_EnableSelfHeal
      })
  ]
}

