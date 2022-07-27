module "database" {
  source  = "../../Modules/Database/0.1.0"

  ProjectName = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  
  CloudSQLAdminPassword = var.CloudSQLAdminPassword
  CloudSQLBackstagePassword = "backstage1234"
  CloudSQLUserPassword = "user1234"
  CloudSQLEnableAutoBackup = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableDiskAutoResize = false
  CloudSQLEnableHighlyAvailable = false
  CloudSQLAllowDeletion = true
  CloudSQLMachine = "db-g1-small"
  IPExpirationTime = "720h" # 720h = 30 days.
  CloudSQLCreateReleaseUserAndDB = false
}