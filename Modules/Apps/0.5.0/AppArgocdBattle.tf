# https://artifacthub.io/packages/helm/argo/argo-cd
# https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml
# https://github.com/argoproj/argo-helm/blob/argo-cd-4.9.8/charts/argo-cd/values.yaml
# helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
# helm uninstall argocd -n argocd

resource "helm_release" "ArgoCDBattle" {
  depends_on = [helm_release.Robusta]

  count = var.ArgoCD_Enable && !var.ArgoCD_EnableAllApps ? 1 : 0

  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "~>4.9.8"

  create_namespace = true
  namespace        = "argocd"

  # Branch or Tag.
  set {
    name  = "server.additionalApplications[0].source.targetRevision"
    value = var.ArgoCD_AppBattleBranchOrTag
  }
  set {
    name  = "server.additionalApplications[1].source.targetRevision"
    value = var.ArgoCD_AppFileBranchOrTag
  }

  # Helm Value File.
  # https://stackoverflow.com/questions/53846273/helm-passing-array-values-through-set
  # [0] Battle service.
  set {
    name  = "server.additionalApplications[0].source.helm.valueFiles"
    value = var.ArgoCD_BattleHelmValueFiles
  }
  # [1] File service.
  set {
    name  = "server.additionalApplications[1].source.helm.valueFiles"
    value = var.ArgoCD_FileHelmValueFiles
  }


  #============================#
  # Set repository credentials #
  #============================#
  # https://github.com/helm/helm/issues/1987
  set_sensitive {
    name  = "configs.repositories.sk-file.username"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "configs.repositories.sk-file.password"
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
    templatefile("${path.module}/Values/argocd-apps-battle.yaml", { enableSelfHeal = var.ArgoCD_EnableSelfHeal })
  ]
}

resource "helm_release" "ArgoCDBattleResources" {
  depends_on = [helm_release.ArgoCDBattle , helm_release.Traefik]

  count = var.ArgoCD_Enable && !var.ArgoCD_EnableAllApps ? 1 : 0

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
}