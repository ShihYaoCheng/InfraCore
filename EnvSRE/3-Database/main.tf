module "database" {
  source  = "../../Modules/Database/0.1.0"

  ProjectName = "cqi-sk-sre"
  GCPProjectID = var.GCPProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  
  CloudSQLAdminPassword = var.CloudSQLAdminPassword
  CloudSQLBackstagePassword = var.CloudSQLBackstagePassword
  CloudSQLUserPassword = var.CloudSQLUserPassword
  CloudSQLEnableAutoBackup = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableDiskAutoResize = false
  CloudSQLEnableHighlyAvailable = false
  CloudSQLAllowDeletion = true
  CloudSQLMachine = "db-g1-small"
  CloudSQLAllowPublicIP = "111.251.22.68/32"
}