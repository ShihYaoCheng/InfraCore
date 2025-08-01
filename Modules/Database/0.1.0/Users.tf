﻿#=====================================================================================#
#                                Backstage                                            #
#=====================================================================================#
# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/user
resource "mysql_user" "cqi-backstage" {
  depends_on         = [module.CloudSQL]
  user               = "cqi-backstage"
  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
  plaintext_password = var.CloudSQLBackstagePassword
}

# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant
resource "mysql_grant" "cqi-backstage" {
  depends_on = [module.CloudSQL]
  user       = mysql_user.cqi-backstage.user
  host       = mysql_user.cqi-backstage.host
  database   = "Backstage"
  privileges = ["ALL PRIVILEGES"]
}

#=====================================================================================#
#                                User                                                 #
#=====================================================================================#
resource "mysql_user" "cqi-user" {
  depends_on         = [module.CloudSQL]
  user               = "cqi-user"
  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
  plaintext_password = var.CloudSQLUserPassword
}

resource "mysql_grant" "cqi-user" {
  depends_on = [module.CloudSQL]
  user       = mysql_user.cqi-user.user
  host       = mysql_user.cqi-user.host
  database   = "User"
  privileges = ["ALL PRIVILEGES"]
}

#=====================================================================================#
#                                User(Release)                                        #
#=====================================================================================#
resource "mysql_user" "cqi-user-rel" {
  count = var.CloudSQLCreateReleaseUserAndDB ? 1 : 0

  depends_on = [module.CloudSQL, mysql_database.UserRel]
  
  user               = "cqi-user-rel"
  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
  plaintext_password = var.CloudSQLUserPassword
}

resource "mysql_grant" "cqi-user-rel" {
  count = var.CloudSQLCreateReleaseUserAndDB ? 1 : 0

  depends_on = [module.CloudSQL]

  user       = mysql_user.cqi-user-rel[count.index].user
  host       = mysql_user.cqi-user-rel[count.index].host
#  database   = "UserRel"
  database   = mysql_database.UserRel[count.index].name
  privileges = ["ALL PRIVILEGES"]
}