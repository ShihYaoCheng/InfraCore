module "DB" {
  source = "../../Modules/Database/0.2.0"

  ProjectName = local.ProjectName

  GCPProjectID = local.ProjectID
  GCPRegion    = var.GCPRegion
  GCPZone      = var.GCPZone

  CloudSQLAdminPassword     = var.CloudSQLAdminPassword
  CloudSQLBackstagePassword = var.CloudSQLBackstagePassword
  CloudSQLUserPassword      = var.CloudSQLUserPassword

#  CloudSQLMachine                   = "db-n1-standard-2"
  CloudSQLMachine                   = "db-g1-small"
  CloudSQLEnableDiskAutoResize      = true
  CloudSQLEnableAutoBackup          = true
  CloudSQLEnablePointInTimeRecovery = true
  CloudSQLEnableHighlyAvailable     = true
  CloudSQLAllowDeletion             = false
  CloudSQLCreateReleaseUserAndDB    = false
}