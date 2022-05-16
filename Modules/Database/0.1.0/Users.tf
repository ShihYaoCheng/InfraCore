

# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/user
resource "mysql_user" "cqi-backstage" {
  user               = "cqi-backstage"
  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
  plaintext_password = var.CloudSQLBackstagePassword
}

# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/grant
resource "mysql_grant" "cqi-backstage" {
  user       = mysql_user.cqi-backstage.user
  host       = mysql_user.cqi-backstage.host
  database   = "Backstage"
  privileges = ["ALL PRIVILEGES"]
}


resource "mysql_user" "cqi-user" {
  user               = "cqi-user"
  host               = "%" // allow any host to connected. Default: localhost(allow localhost connected only).
  plaintext_password = var.CloudSQLUserPassword
}

resource "mysql_grant" "cqi-user" {
  user       = mysql_user.cqi-user.user
  host       = mysql_user.cqi-user.host
  database   = "User"
  privileges = ["ALL PRIVILEGES"]
}