module "database" {
  source  = "../../Modules/Database/0.1.0"

  ProjectName = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
  GCPZone = local.GCPZone
  
  CloudSQLAdminPassword = "admin1234"
  CloudSQLBackstagePassword = "backstage1234"
  CloudSQLUserPassword = "user1234"
  CloudSQLEnableAutoBackup = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableDiskAutoResize = false
  CloudSQLEnableHighlyAvailable = false
  CloudSQLAllowDeletion = true
  CloudSQLMachine = "db-f1-micro"
  IPExpirationTime = "720h" # 720h = 30 days.
}