module "database" {
  source = "../../Modules/Database/0.1.0"

  ProjectName  = file("../ProjectName.txt")
  GCPProjectID = local.ProjectID
  GCPRegion    = var.GCPRegion
  GCPZone      = var.GCPZone

  CloudSQLAdminPassword     = local.CloudSQLAdminPassword
  CloudSQLBackstagePassword = "backstage1234"
  CloudSQLUserPassword      = "user1234"

  CloudSQLMachine                   = "db-g1-small"
  CloudSQLEnableDiskAutoResize      = false
  CloudSQLEnableAutoBackup          = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableHighlyAvailable     = false
  CloudSQLAllowDeletion             = true
  IPExpirationTime                  = "720h" # 30 days.
}