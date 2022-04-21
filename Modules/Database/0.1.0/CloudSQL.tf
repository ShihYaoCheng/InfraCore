
resource "random_id" "CloudSQLID" {
  byte_length = 2
}

# https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest/submodules/mysql
module "CloudSQL" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "10.0.1"

  database_version = "MYSQL_8_0"
  encryption_key_name = null
  name = "${var.ProjectName}-${random_id.CloudSQLID.dec}"
  project_id = var.GCPProjectID
  region = var.GCPRegion
  zone = var.GCPZone

  activation_policy = "ALWAYS" # The instance is always up and running.
#  activation_policy = "NEVER"

  # The availability type for the master instance. Can be either REGIONAL or null.
#  availability_type = "REGIONAL"
  availability_type = null

  backup_configuration = {
    # (Optional) True if binary logging is enabled. Cannot be used with Postgres.
    binary_log_enabled             = false
    enabled                        = true
    start_time                     = "17:00" # AM 1 ~ AM 5, UTC+8
    # (Optional) The region where the backup will be stored.
    location                       = null
    # (Optional) The number of days of transaction logs we retain for point in time restore, from 1-7.
    transaction_log_retention_days = null
    # (Optional) Depending on the value of retention_unit, this is used to determine if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups.
    retained_backups               = null
    # (Optional) The unit that 'retained_backups' represents. Defaults to COUNT.
    retention_unit                 = null
  }

  enable_default_db = false

  # create a root user.
  enable_default_user = true
  user_name = "root"
  user_password = var.CloudSQLRootPassword

  # The day of week (1-7) for the master instance maintenance.
  # 1: Monday, 2: Tuesday... 7:Sunday
  maintenance_window_day = 5
  maintenance_window_hour = 22
  maintenance_window_update_track = "stable"

  ip_configuration = {
    "allocated_ip_range": null,
    "authorized_networks": [{value = "118.168.19.86/32"}],
    "ipv4_enabled": true,
    "private_network": null,
    "require_ssl": null
  }

  # Used to block Terraform from deleting a SQL Instance.
  deletion_protection = false

  # db-f1-micro, db-g1-small, db-n1-standard-1, db-n1-standard-2, db-n1-standard-4,
  # db-n1-standard-8, db-n1-standard-16, db-n1-standard-32, db-n1-standard-64,
  # db-n1-standard-96, db-n1-highmem-2, db-n1-highmem-4, db-n1-highmem-8, db-n1-highmem-16,
  # db-n1-highmem-32, db-n1-highmem-64, db-n1-highmem-96.
  # db-custom-#-#
  # db-custom-1-3840(1 vCPU, 3840MB)
  tier = "db-n1-standard-2" # default: db-n1-standard-1
}


# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database
resource "mysql_database" "User" {
  name = "User"
}

# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/user
resource "mysql_user" "cqi-user" {
  user               = "cqi-user"
  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
  plaintext_password = "cqig7777"
}

# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant
resource "mysql_grant" "cqi-user" {
  user       = mysql_user.cqi-user.user
  host       = mysql_user.cqi-user.host
  database   = "User"
  privileges = ["ALL PRIVILEGES"]
}
