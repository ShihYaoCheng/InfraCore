
# https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest/submodules/mysql
module "cloud-sql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "10.0.1"

  database_version = "MYSQL_8_0"
  encryption_key_name = null
  name = var.ProjectName
  project_id = var.GCPProjectID
  region = var.GCPRegion
  zone = var.GCPZone

  activation_policy = "ALWAYS"
#  activation_policy = "NEVER"

  availability_type = null

  backup_configuration = {
    binary_log_enabled             = false
    enabled                        = true
    start_time                     = null
    location                       = null
    transaction_log_retention_days = null
    retained_backups               = null
    retention_unit                 = null
  }

  enable_default_db = false
  enable_default_user = false

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

  deletion_protection = false
}

#resource "google_sql_user" "superuser" {
#  name     = "root"
#  instance = google_sql_database_instance.master.name
#  password = "rrr666"
#  host = "%"
#}
#
#// https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database
#resource "mysql_database" "token" {
#  name = "dz-token"
#}
#
#// https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database
#resource "mysql_database" "user" {
#  name = "dz-user"
#}
#
#// https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/user
#resource "mysql_user" "dev" {
#  user               = "dev"
#  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
#  plaintext_password = "dev666"
#}
#
#// https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant
#resource "mysql_grant" "dev-token" {
#  user       = mysql_user.dev.user
#  host       = mysql_user.dev.host
#  database   = "dz-token"
#  privileges = ["ALL PRIVILEGES"]
#}
#
#resource "mysql_grant" "dev-user" {
#  user       = mysql_user.dev.user
#  host       = mysql_user.dev.host
#  database   = "dz-user"
#  privileges = ["ALL PRIVILEGES"]
#}