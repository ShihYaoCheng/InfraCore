module "DB" {
  source = "../../Modules/Database/0.1.0"

  ProjectName  = local.ProjectName
  
  GCPProjectID = local.ProjectID
  GCPRegion    = var.GCPRegion
  GCPZone      = var.GCPZone

  CloudSQLAdminPassword     = var.CloudSQLAdminPassword
  CloudSQLBackstagePassword = var.CloudSQLBackstagePassword
  CloudSQLUserPassword      = var.CloudSQLUserPassword

  CloudSQLMachine                   = "db-n1-standard-2"
  CloudSQLEnableDiskAutoResize      = true
  CloudSQLEnableAutoBackup          = true
  CloudSQLEnablePointInTimeRecovery = true
  CloudSQLEnableHighlyAvailable     = true
  CloudSQLAllowDeletion             = true
  IPExpirationTime                  = "1440h" # 60 days.
}