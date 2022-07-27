#============================
# Project                   #
#============================
variable "ProjectName" {
  type = string
}

variable "GCPProjectID" {
  type = string
}

# https://cloud.google.com/compute/docs/regions-zones
variable "GCPRegion" {
  type        = string
  description = "cloud provider region."
}

variable "GCPZone" {
  type        = string
  #  default     = "asia-east1-b"
  description = "cloud provider zone."
}

#============================
# CloudSQL                  #
#============================
# https://cloud.google.com/sql/docs/mysql/instance-settings
# db-f1-micro, db-g1-small, db-n1-standard-1, db-n1-standard-2, db-n1-standard-4,
# db-n1-standard-8, db-n1-standard-16, db-n1-standard-32, db-n1-standard-64,
# db-n1-standard-96, db-n1-highmem-2, db-n1-highmem-4, db-n1-highmem-8, db-n1-highmem-16,
# db-n1-highmem-32, db-n1-highmem-64, db-n1-highmem-96.
# db-custom-#-#
# db-custom-1-3840(1 vCPU, 3840MB)
variable "CloudSQLMachine" {
  type = string
#  default = "db-n1-standard-1"
  description = "https://cloud.google.com/sql/docs/mysql/instance-settings"
}

variable "CloudSQLEnableDiskAutoResize" {
  type = bool
#  default = true
}

variable "CloudSQLEnableAutoBackup" {
  type = bool
#  default = true
}

variable "CloudSQLEnablePointInTimeRecovery" {
  type = bool
#  default = true
}

variable "CloudSQLEnableHighlyAvailable" {
  type = bool
#  default = false
}

variable "CloudSQLAllowDeletion" {
  type = bool
#  default = false
}

locals {
  AdminName = "cqi-admin"
}

# https://www.terraform.io/language/functions/timeadd
variable "IPExpirationTime" {
  type = string
#  default = "120h"
  description = "120h = 5 days."
}

variable "CloudSQLAdminPassword" {
  type = string
  sensitive = true
}

variable "CloudSQLUserPassword" {
  type = string
  sensitive = true
}

variable "CloudSQLBackstagePassword" {
  type = string
  sensitive = true
}

variable "CloudSQLCreateReleaseUserAndDB" {
  type = bool
}
