module "database" {
  source  = "../../Modules/Database/0.1.0"

  ProjectName = file("../ProjectName.txt")
  GCPProjectID = local.ProjectID
  GCPRegion = var.GCPRegion
  GCPZone = var.GCPZone
  
  CloudSQLAdminPassword = "admin1234"
  CloudSQLBackstagePassword = "backstage1234"
  CloudSQLUserPassword = "user1234"
  CloudSQLEnableAutoBackup = false
  CloudSQLEnablePointInTimeRecovery = false
  CloudSQLEnableDiskAutoResize = false
  CloudSQLEnableHighlyAvailable = false
  CloudSQLAllowDeletion = true
  CloudSQLMachine = "db-f1-micro"
}