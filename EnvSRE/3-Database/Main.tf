﻿module "database" {
  source  = "../../Modules/Database/0.5.0"

  ProjectName = local.ProjectName
  GCPProjectID = local.ProjectID
  GCPRegion = local.GCPRegion
  GCPZone = local.GCPZone
  
  CloudSQLAdminPassword = local.CloudSQLAdminPassword
  CloudSQLBackstagePassword = "backstage1234"
  CloudSQLUserPassword = "user1234"
  CloudSQLEnableAutoBackup = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableDiskAutoResize = false
  CloudSQLEnableHighlyAvailable = false
  CloudSQLAllowDeletion = true
  CloudSQLMachine = "db-g1-small"
  CloudSQLCreateReleaseUserAndDB = true
}