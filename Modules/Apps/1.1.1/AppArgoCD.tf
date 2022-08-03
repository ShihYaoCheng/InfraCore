# https://artifacthub.io/packages/helm/argo/argo-cd
# https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml
# https://github.com/argoproj/argo-helm/blob/argo-cd-4.9.8/charts/argo-cd/values.yaml
# helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
# helm uninstall argocd -n argocd

resource "helm_release" "ArgoCD" {
  depends_on = [helm_release.Robusta]

  count = var.ArgoCD_Enable ? 1 : 0

  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "~>4.10.4"

  create_namespace = true
  namespace        = "argocd"

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
      })
  ]
}

resource "helm_release" "ArgoCDResource" {
  depends_on = [helm_release.ArgoCD, helm_release.Traefik]

  count = var.ArgoCD_Enable ? 1 : 0

  name      = "argocd-resources"
  chart     = "${path.module}/Charts/argocd-res"
  namespace = "argocd"

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
  
  set_sensitive {
    name  = "repository.userName"
    value = var.ArgoCD_GitLabTokenName
  }
  set_sensitive {
    name  = "repository.password"
    value = var.ArgoCD_GitLabTokenSecret
  }

  set {
    name  = "apps.battle.enabled"
    value = var.ArgoCD_EnableAppBattle
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
    value = var.ArgoCD_EnableAppFile
  }
  set {
    name  = "apps.file.branchOrTag"
    value = var.ArgoCD_AppFileBranchOrTag
  }
  set {
    name  = "apps.file.valueFiles"
    value = var.ArgoCD_FileHelmValueFiles
  }

  set {
    name  = "apps.table.enabled"
    value = var.ArgoCD_EnableAppTable
  }
  set {
    name  = "apps.table.branchOrTag"
    value = var.ArgoCD_AppTableBranchOrTag
  }
  set {
    name  = "apps.table.valueFiles"
    value = var.ArgoCD_TableHelmValueFiles
  }

  set {
    name  = "apps.user.enabled"
    value = var.ArgoCD_EnableAppUser
  }
  set {
    name  = "apps.user.branchOrTag"
    value = var.ArgoCD_AppUserBranchOrTag
  }
  set {
    name  = "apps.user.valueFiles"
    value = var.ArgoCD_UserHelmValueFiles
  }
  set {
    name  = "apps.user.sqlPassword"
    value = var.ArgoCD_UserSqlPassword
  }

  set {
    name  = "apps.backstage.enabled"
    value = var.ArgoCD_EnableAppBackstage
  }
  set {
    name  = "apps.backstage.branchOrTag"
    value = var.ArgoCD_AppBackstageBranchOrTag
  }
  set {
    name  = "apps.backstage.valueFiles"
    value = var.ArgoCD_BackstageHelmValueFiles
  }
  set {
    name  = "apps.backstage.sqlPassword"
    value = var.ArgoCD_BackstageSqlPassword
  }

  set {
    name  = "apps.officialWeb.enabled"
    value = var.ArgoCD_EnableAppOfficialWeb
  }
  set {
    name  = "apps.officialWeb.branchOrTag"
    value = var.ArgoCD_AppOfficialWebBranchOrTag
  }
  set {
    name  = "apps.officialWeb.valueFiles"
    value = var.ArgoCD_OfficialWebHelmValueFiles
  }
  set {
    name  = "apps.officialWeb.sqlPassword"
    value = var.ArgoCD_BackstageSqlPassword
  }

  set {
    name  = "apps.nft.enabled"
    value = var.ArgoCD_EnableAppNFT
  }
  set {
    name  = "apps.nft.branchOrTag"
    value = var.ArgoCD_AppNFTBranchOrTag
  }
  set {
    name  = "apps.nft.valueFiles"
    value = var.ArgoCD_NFTHelmValueFiles
  }
}
