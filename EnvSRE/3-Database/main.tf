module "database" {
  source  = "../../Modules/Database/0.1.0"

  ProjectName = "cqi-sk-sre"
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  
  CloudSQLRootPassword = var.CloudSQLRootPassword
  CloudSQLBackstagePassword = var.CloudSQLBackstagePassword
  CloudSQLUserPassword = var.CloudSQLUserPassword
  CloudSQLEnableAutoBackup = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableDiskAutoResize = false
  CloudSQLEnableHighlyAvailable = false
  CloudSQLMachine = "db-g1-small"
}