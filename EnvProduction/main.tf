module "infra" {
  source = "../env-core/0.1.0"

  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  ProjectEnvironment = "prod"

  GKERegional = true
  GKEZones = ["asia-east1-a"]
  GKEMinNodeCount = 1
  GKEMaxNodeCount = 10

  SealedSecretPublicKey = var.SealedSecretPublicKey
  SealedSecretPrivateKey = var.SealedSecretPrivateKey

  GodaddyAPIKey = var.GodaddyAPIKey
  GodaddyAPISecret = var.GodaddyAPISecret

  ArgoCD_GitLabTokenName = var.ArgoCD_GitLabTokenName
  ArgoCD_GitLabTokenSecret = var.ArgoCD_GitLabTokenSecret
  ArgoCD_AppTokenBranchOrTag = "0.1.3"
  ArgoCD_AppUserBranchOrTag = "0.1.4"
  ArgoCD_RepositoryHelmPathValueFiles = "{../values-prod.yaml}"
  ArgoCD_ApplicationPublicKey = var.ArgoCD_ApplicationPublicKey
  ArgoCD_ApplicationPrivateKey = var.ArgoCD_ApplicationPrivateKey

  AlertSlackChannel = "alert-prod"
  GrafanaAdminPassword = var.GrafanaAdminPassword

  CreateProductionCertificate = true
  UseProductionCertificate = true
}


