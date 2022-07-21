# https://artifacthub.io/packages/helm/argo/argo-cd
# https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml
# https://github.com/argoproj/argo-helm/blob/argo-cd-4.9.8/charts/argo-cd/values.yaml
# helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
# helm uninstall argocd -n argocd

resource "helm_release" "ArgoCDFull" {
  depends_on = [helm_release.Robusta]

  count = var.ArgoCD_Enable && var.ArgoCD_EnableAllApps ? 1 : 0

  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "~>4.9.16"

  create_namespace = true
  namespace        = "argocd"

  # Branch or Tag.
#  set {
#    name  = "server.additionalApplications[1].source.targetRevision"
#    value = var.ArgoCD_AppFileBranchOrTag
#  }
#  set {
#    name  = "server.additionalApplications[2].source.targetRevision"
#    value = var.ArgoCD_AppTableBranchOrTag
#  }
#  set {
#    name  = "server.additionalApplications[3].source.targetRevision"
#    value = var.ArgoCD_AppUserBranchOrTag
#  }
#  set {
#    name  = "server.additionalApplications[4].source.targetRevision"
#    value = var.ArgoCD_AppBackstageBranchOrTag
#  }
#  set {
#    name  = "server.additionalApplications[5].source.targetRevision"
#    value = var.ArgoCD_AppNFTBranchOrTag
#  }

  # Helm Value File.
  # https://stackoverflow.com/questions/53846273/helm-passing-array-values-through-set
  # [0] Battle service.
#  # [1] File service.
#  set {
#    name  = "server.additionalApplications[1].source.helm.valueFiles"
#    value = var.ArgoCD_FileHelmValueFiles
#  }
#  # [2] Table service.
#  set {
#    name  = "server.additionalApplications[2].source.helm.valueFiles"
#    value = var.ArgoCD_TableHelmValueFiles
#  }
#  # [3] User service.
#  set {
#    name  = "server.additionalApplications[3].source.helm.valueFiles"
#    value = var.ArgoCD_UserHelmValueFiles
#  }
#  # [4] Backstage
#  set {
#    name  = "server.additionalApplications[4].source.helm.valueFiles"
#    value = var.ArgoCD_BackstageHelmValueFiles
#  }
#  # [5] NFT
#  set {
#    name  = "server.additionalApplications[5].source.helm.valueFiles"
#    value = var.ArgoCD_NFTHelmValueFiles
#  }



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
    templatefile("${path.module}/Values/ArgoCD-Projects.yaml", 
      {
        syncWindowCronTime = var.ArgoCD_SyncWindowTaipeiTime
      }),
    templatefile("${path.module}/Values/ArgoCD-Server.yaml", 
      {
        serverExtraArgs = var.ArgoCD_EnableIngress ? "[--insecure, --basehref, /argocd]" : "[]"
      }),
    templatefile("${path.module}/Values/argocd-apps-full.yaml", 
      { 
        enableSelfHeal = var.ArgoCD_EnableSelfHeal
      })
  ]
}

resource "helm_release" "ArgoCDFullResources" {
  depends_on = [helm_release.ArgoCDFull , helm_release.Traefik]

  count = var.ArgoCD_Enable && var.ArgoCD_EnableAllApps ? 1 : 0
  
  name             = "argocd-resources"
  chart            = "${path.module}/Charts/argocd-res"
  namespace        = "argocd"

  set {
    name  = "ingress.enabled"
    value = var.ArgoCD_EnableIngress
  }

  set {
    name  = "ingress.useProdCert"
    value = var.ArgoCD_IngressUseProdCert
  }

  set {
    name  = "apps.selfHeal"
    value = var.ArgoCD_EnableSelfHeal
  }

  set {
    name  = "apps.battle.enabled"
    value = true
  }

  set {
    name  = "apps.battle.branchOrTag"
    value = var.ArgoCD_AppBattleBranchOrTag
  }

  set {
    name  = "apps.battle.valueFiles"
    value = var.ArgoCD_BattleHelmValueFiles
  }

  set {
    name  = "apps.file.enabled"
    value = true
  }

  set {
    name  = "apps.file.branchOrTag"
    value = var.ArgoCD_AppFileBranchOrTag
  }

  set {
    name  = "apps.file.valueFiles"
    value = var.ArgoCD_FileHelmValueFiles
  }
}
