resource "random_id" "CloudSQLID" {
  byte_length = 2
}

data "http" "MyIP" {
  url = "http://ipv4.icanhazip.com"
}

# https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest/submodules/mysql
module "CloudSQL" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "10.0.2"

  database_version    = "MYSQL_8_0"
  encryption_key_name = null
  name                = "${var.ProjectName}-${random_id.CloudSQLID.dec}"
  project_id          = var.GCPProjectID
  region              = var.GCPRegion
  zone                = var.GCPZone

  # https://cloud.google.com/sql/docs/mysql/start-stop-restart-instance#activation_policy
  #  activation_policy = "ALWAYS" # The instance is always up and running.

  availability_type = var.CloudSQLEnableHighlyAvailable ? "REGIONAL" : null

  disk_autoresize = var.CloudSQLEnableDiskAutoResize

  backup_configuration = {
    enabled = var.CloudSQLEnableAutoBackup # default: false

    # https://www.sqlshack.com/learn-mysql-an-overview-of-mysql-binary-logs/
    # The binary logs are used for master-slave replication(data sync).
    # The binary logs can be used to perform the point in time recovery.
    binary_log_enabled = var.CloudSQLEnableAutoBackup && var.CloudSQLEnablePointInTimeRecovery # default: false

    start_time = "17:00" # default: null, AM 1 ~ AM 5, UTC+8

    # (Optional) The region where the backup will be stored.
    location = var.CloudSQLEnableHighlyAvailable ? var.GCPRegion : null # default: null

    # (Optional) The number of days of transaction logs we retain for point in time restore, from 1-7.
    # To set the number of days to retain binary logs (from 1 to 7):
    # https://cloud.google.com/sql/docs/mysql/backup-recovery/pitr#set-retention
    transaction_log_retention_days = null # default: null(=7 day)

    # (Optional) Depending on the value of retention_unit, this is used to determine 
    # if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups.
    retained_backups = null # default: null(=7 day)

    # (Optional) The unit that 'retained_backups' represents. Defaults to COUNT.
    retention_unit = null # default: null
  }

  enable_default_db = false

  # create a super user.
  enable_default_user = true
  user_name           = local.AdminName
  user_password       = var.CloudSQLAdminPassword

  # https://cloud.google.com/sql/docs/mysql/maintenance
  # update CloudSQL features, Database version upgrades, Operating system patches.
  # The day of week (1-7) for the master instance maintenance.
  # 1: Monday, 2: Tuesday... 7:Sunday
  maintenance_window_day          = 5
  maintenance_window_hour         = 22
  maintenance_window_update_track = "stable"

  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
  # https://www.unixtimestamp.com/
  # https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add
  ip_configuration = {
    "allocated_ip_range" : null,
    "authorized_networks" : [
      { 
        value = "${chomp(data.http.MyIP.body)}/32"
#        expiration_time = timeadd(timestamp(), var.IPExpirationTime)
      }],
    "ipv4_enabled" : true,
    "private_network" : null,
    "require_ssl" : null
  }

  # Used to block Terraform from deleting a SQL Instance.
  deletion_protection = !var.CloudSQLAllowDeletion

  # db-f1-micro, db-g1-small, db-n1-standard-1, db-n1-standard-2, db-n1-standard-4,
  # db-n1-standard-8, db-n1-standard-16, db-n1-standard-32, db-n1-standard-64,
  # db-n1-standard-96, db-n1-highmem-2, db-n1-highmem-4, db-n1-highmem-8, db-n1-highmem-16,
  # db-n1-highmem-32, db-n1-highmem-64, db-n1-highmem-96.
  # db-custom-#-#
  # db-custom-1-3840(1 vCPU, 3840MB)
  tier = var.CloudSQLMachine
  
  create_timeout = var.CloudSQLMachine == "db-f1-micro" ? "20m" : "10m"
}

# require permission: Storage Admin
resource "google_storage_bucket_object" "CloudSQLConnectionName" {
  bucket  = var.ProjectName
  name    = "CloudSQLConnectionName"
  content = module.CloudSQL.instance_connection_name
}

