module "database" {
  source = "../../Modules/Database/0.5.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion    = local.GCPRegion
  GCPZone      = local.GCPZone

  CloudSQLAdminPassword     = local.CloudSQLAdminPassword
  CloudSQLBackstagePassword = "backstage1234"
  CloudSQLUserPassword      = "user1234"

  CloudSQLMachine                   = "db-f1-micro"
  CloudSQLEnableDiskAutoResize      = false
  CloudSQLEnableAutoBackup          = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableHighlyAvailable     = false
  CloudSQLAllowDeletion             = true
  CloudSQLCreateReleaseUserAndDB    = false
}